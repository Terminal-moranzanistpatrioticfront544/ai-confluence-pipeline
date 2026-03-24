#!/usr/bin/env bash
# ============================================================================
# Generate a technical analysis and save as local markdown for review.
#
# Usage:
#   ./scripts/trigger-preview.sh "Add user notification preferences"
#   ./scripts/trigger-preview.sh "Add user notification preferences" --context "We use Firebase"
#
# Output:
#   preview/<timestamp>-<slug>.md    — readable markdown (edit this)
#   preview/<timestamp>-<slug>.json  — raw analysis data (used by push script)
#
# After reviewing/editing the markdown, push to Confluence:
#   ./scripts/push-to-confluence.sh preview/<timestamp>-<slug>.json
# ============================================================================

set -euo pipefail

WEBHOOK_URL="${WEBHOOK_URL:-http://localhost:10353/webhook/preview}"
PREVIEW_DIR="$(cd "$(dirname "$0")/.." && pwd)/preview"
FEATURE_DESCRIPTION="$1"
ADDITIONAL_CONTEXT=""

shift || true
while [[ $# -gt 0 ]]; do
  case $1 in
    --context)
      ADDITIONAL_CONTEXT="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

if [ -z "$FEATURE_DESCRIPTION" ]; then
  echo "Usage: $0 <feature-description> [--context <context>]"
  exit 1
fi

echo "Generating analysis for: $FEATURE_DESCRIPTION"
echo ""

RESPONSE=$(curl -s -X POST "$WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg desc "$FEATURE_DESCRIPTION" \
    --arg ctx "$ADDITIONAL_CONTEXT" \
    '{
      featureDescription: $desc,
      additionalContext: $ctx
    }')")

# Check for errors
if ! echo "$RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
  echo "Error from pipeline:"
  echo "$RESPONSE" | jq '.' 2>/dev/null || echo "$RESPONSE"
  exit 1
fi

# Extract title and create filename
TITLE=$(echo "$RESPONSE" | jq -r '.title')
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//' | cut -c1-50)
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
FILENAME="${TIMESTAMP}-${SLUG}"

# Save markdown (for review/editing)
echo "$RESPONSE" | jq -r '.markdown' > "${PREVIEW_DIR}/${FILENAME}.md"

# Save JSON (for push-to-confluence)
echo "$RESPONSE" | jq '.analysis' > "${PREVIEW_DIR}/${FILENAME}.json"

echo "Preview saved:"
echo "  Markdown: preview/${FILENAME}.md"
echo "  Data:     preview/${FILENAME}.json"
echo ""
echo "Next steps:"
echo "  1. Review and edit: preview/${FILENAME}.md"
echo "  2. Push to Confluence: ./scripts/push-to-confluence.sh preview/${FILENAME}.json"
echo "  3. Push to Confluence + create Jira tickets: ./scripts/push-to-confluence.sh preview/${FILENAME}.json --jira"
