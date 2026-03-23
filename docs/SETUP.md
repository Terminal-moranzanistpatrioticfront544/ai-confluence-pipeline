# Setup Guide

## Prerequisites

- Docker & Docker Compose
- Confluence Cloud (with API token)
- Jira Cloud (with API token) — optional
- Anthropic API key (or OpenAI)

## 1. Get Your API Tokens

### Confluence & Jira API Token
1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click "Create API token"
3. Copy the token — this works for both Confluence and Jira

### Anthropic API Key
1. Go to https://console.anthropic.com/
2. Create an API key

## 2. Configure Environment

```bash
cp .env.example .env
```

Edit `.env` with your values:
- `ANTHROPIC_API_KEY` — your Claude API key
- `CONFLUENCE_BASE_URL` — e.g., `https://yourcompany.atlassian.net`
- `CONFLUENCE_EMAIL` — your Atlassian email
- `CONFLUENCE_API_TOKEN` — from step 1
- `CONFLUENCE_SPACE_KEY` — the Confluence space key (e.g., `TECH`)
- `JIRA_*` — same as Confluence if using the same Atlassian instance

## 3. Start n8n

```bash
docker compose up -d
```

Open http://localhost:5678 and log in with the credentials from `.env`.

## 4. Import the Workflow

1. In n8n, go to **Workflows** → **Import from file**
2. Select `workflows/technical-analysis-pipeline.json`
3. Configure credentials:
   - Create "HTTP Basic Auth" credential for Confluence (email + API token)
   - Create "HTTP Basic Auth" credential for Jira (email + API token)
4. Activate the workflow

## 5. Test It

```bash
# Bash
./scripts/trigger-analysis.sh "Add user notification preferences with email and push channels"

# PowerShell
.\scripts\trigger-analysis.ps1 -Description "Add user notification preferences with email and push channels"
```

## 6. Customize

- Edit prompts in `prompts/` to match your team's conventions
- Modify the "Format for Confluence" node to match your page templates
- Add labels, components, or custom fields to the Jira issue creation

## Troubleshooting

### "401 Unauthorized" from Confluence/Jira
- Verify your email and API token in the n8n credentials
- Make sure you're using the email associated with your Atlassian account

### AI response parsing fails
- Check the "Parse AI Response" node execution data in n8n
- The AI sometimes wraps JSON in markdown fences — the parser handles this, but edge cases exist
- Try switching to `claude-opus-4-6` for more reliable structured output

### Confluence page formatting looks wrong
- Confluence uses its own "storage format" (XHTML-like)
- Check the "Format for Confluence" node — you may need to adjust HTML tags
- Use `<ac:structured-macro>` for code blocks, panels, etc.
