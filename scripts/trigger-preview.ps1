# ============================================================================
# Generate a technical analysis and save as local markdown for review.
#
# Usage:
#   .\scripts\trigger-preview.ps1 -Description "Add user notification preferences"
#   .\scripts\trigger-preview.ps1 -Description "Add user notification preferences" -Context "We use Firebase"
#
# Output:
#   preview/<timestamp>-<slug>.md    — readable markdown (edit this)
#   preview/<timestamp>-<slug>.json  — raw analysis data (used by push script)
#
# After reviewing/editing the markdown, push to Confluence:
#   .\scripts\push-to-confluence.ps1 -File preview/<timestamp>-<slug>.json
# ============================================================================

param(
    [Parameter(Mandatory = $true)]
    [string]$Description,

    [string]$Context = ""
)

$WebhookUrl = if ($env:WEBHOOK_URL) { $env:WEBHOOK_URL } else { "http://localhost:10353/webhook/preview" }
$PreviewDir = Join-Path $PSScriptRoot "..\preview"

$body = @{
    featureDescription = $Description
    additionalContext  = $Context
} | ConvertTo-Json -Depth 10

Write-Host "Generating analysis for: $Description" -ForegroundColor Cyan
Write-Host ""

try {
    $response = Invoke-RestMethod -Uri $WebhookUrl -Method POST -Body $body -ContentType "application/json"
}
catch {
    Write-Host "Error from pipeline: $_" -ForegroundColor Red
    exit 1
}

# Create filename from title
$title = $response.title
$slug = ($title.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-|-$', '').Substring(0, [Math]::Min(50, ($title.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-|-$', '').Length))
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$filename = "${timestamp}-${slug}"

# Save markdown
$response.markdown | Out-File -FilePath (Join-Path $PreviewDir "${filename}.md") -Encoding utf8

# Save JSON
$response.analysis | ConvertTo-Json -Depth 20 | Out-File -FilePath (Join-Path $PreviewDir "${filename}.json") -Encoding utf8

Write-Host "Preview saved:" -ForegroundColor Green
Write-Host "  Markdown: preview\${filename}.md"
Write-Host "  Data:     preview\${filename}.json"
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Review and edit: preview\${filename}.md"
Write-Host "  2. Push to Confluence: .\scripts\push-to-confluence.ps1 -File preview\${filename}.json"
Write-Host "  3. Push + Jira tickets: .\scripts\push-to-confluence.ps1 -File preview\${filename}.json -CreateJira"
