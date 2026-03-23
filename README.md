# AI Confluence Pipeline

Automate technical analysis with AI, push it to Confluence, and create Jira tasks — all in one workflow.

Built for **tech leads** who spend too much time writing technical docs and creating tickets manually.

```
Feature Description → AI Analysis → Confluence Page → Jira Tasks
```

## What It Does

1. You describe a feature, bug, or research spike
2. AI (Claude or OpenAI) generates a structured technical analysis:
   - Architecture overview with component breakdown
   - API contracts with request/response examples
   - Database schema changes
   - Edge cases and security considerations
   - Testing strategy
   - Task breakdown with acceptance criteria
3. Creates a formatted Confluence page with the full analysis
4. Creates Jira tickets for each task, linked back to the Confluence page

## Quick Start

```bash
# 1. Clone
git clone https://github.com/openmindednewby/ai-confluence-pipeline.git
cd ai-confluence-pipeline

# 2. Configure
cp .env.example .env
# Edit .env with your API keys (see docs/SETUP.md)

# 3. Start n8n
docker compose up -d

# 4. Import workflow
# Open http://localhost:5678 → Import → workflows/technical-analysis-pipeline.json

# 5. Run it
./scripts/trigger-analysis.sh "Add user notification preferences with email and push channels"
```

## Example Output

**Input:**
> "Add user notification preferences with email, push, and in-app channels. Users should be able to configure which events trigger notifications and through which channels."

**Output:**
- Confluence page with architecture, API specs, database changes, edge cases, and task breakdown
- 6-8 Jira tickets with acceptance criteria, estimates, and component labels

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌──────────────┐     ┌─────────┐
│   Trigger    │────▶│  Claude AI   │────▶│  Confluence   │────▶│  Jira   │
│  (webhook)   │     │  (analysis)  │     │  (page)       │     │ (tasks) │
└─────────────┘     └─────────────┘     └──────────────┘     └─────────┘
       │                    │                    │                   │
       │              Structured            Formatted           Tickets
       │              JSON output           HTML page          with AC
       │                                                     & estimates
  Feature desc,
  options, context
```

**Orchestrated by n8n** (self-hosted, open-source workflow automation).

## Included Prompt Templates

| Template | Use Case | Output |
|----------|----------|--------|
| [Technical Analysis](prompts/technical-analysis.md) | New features | Architecture, APIs, DB, tasks |
| [Bug Analysis](prompts/bug-analysis.md) | Bug reports | Root cause, fix plan, tasks |
| [Spike Analysis](prompts/spike-analysis.md) | Research/evaluation | Options matrix, PoC plan, tasks |

## Trigger Methods

```bash
# CLI (Bash)
./scripts/trigger-analysis.sh "Add feature X"
./scripts/trigger-analysis.sh "Add feature X" --no-jira
./scripts/trigger-analysis.sh "Add feature X" --context "We use PostgreSQL"

# CLI (PowerShell)
.\scripts\trigger-analysis.ps1 -Description "Add feature X"
.\scripts\trigger-analysis.ps1 -Description "Add feature X" -NoJira
.\scripts\trigger-analysis.ps1 -Description "Add feature X" -Context "We use PostgreSQL"

# Direct API call
curl -X POST http://localhost:5678/webhook/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "featureDescription": "Add feature X",
    "createJiraTasks": true,
    "additionalContext": "We use PostgreSQL"
  }'
```

## Customization

See [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md) for:
- Writing custom prompt templates
- Injecting your tech stack context
- Confluence page formatting and macros
- Jira custom fields, epic linking, sprint assignment
- Adding Slack notifications
- Batch processing multiple features

## Requirements

- Docker & Docker Compose
- Confluence Cloud + API token
- Jira Cloud + API token (optional)
- Anthropic or OpenAI API key

## FAQ

**Can I use OpenAI instead of Claude?**
Yes. Change `AI_PROVIDER=openai` in `.env` and modify the "Call Claude API" node to use the OpenAI messages endpoint. The prompt templates work with any model.

**Does this work with Confluence Server (on-premise)?**
Yes, but the API endpoints differ slightly. Confluence Server uses `/rest/api/content` without the `/wiki` prefix. Update the URL in the n8n node.

**Can I use this without Jira?**
Yes. Pass `createJiraTasks: false` or use the `--no-jira` flag. You'll still get the Confluence page.

**Can I run this without Docker?**
Yes. Install n8n globally with `npm install -g n8n`, then `n8n start`. Import the workflow the same way.

**How do I add this to a CI/CD pipeline?**
Trigger the webhook from your CI — e.g., when a specific label is added to a GitHub issue, a GitHub Action calls the webhook with the issue body.

## Contributing

Contributions welcome. Some ideas:

- [ ] Additional prompt templates (API migration, performance audit, etc.)
- [ ] OpenAI node variant (pre-configured)
- [ ] GitHub Issues integration (alternative to Jira)
- [ ] Linear integration
- [ ] Confluence page templates with better formatting
- [ ] n8n credential setup script
- [ ] Mermaid diagram generation in Confluence

## License

MIT — see [LICENSE](LICENSE).
