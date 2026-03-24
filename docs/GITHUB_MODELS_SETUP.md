# GitHub Models API Setup (Free — No API Key Needed)

The GitHub Models API gives you free access to GPT-4o, Claude, Llama, and other models using just your GitHub account. No paid API key required.

## How It Works

GitHub hosts AI models and exposes them via an OpenAI-compatible REST API at `https://models.github.ai`. You authenticate with a GitHub Personal Access Token (PAT) — the same kind you use for `git push`.

## Rate Limits (Free Tier)

| Model Tier | Requests/min | Requests/day | Tokens/request |
|------------|-------------|-------------|----------------|
| High (GPT-4o, Claude) | 10 | 50 | 8,000 |
| Low (GPT-4o-mini, Llama) | 15 | 150 | 8,000 |
| Embedding | 15 | 150 | 8,000 |

For this pipeline (1 analysis = 1 API call), 50 requests/day is more than enough for most tech leads.

> **Copilot subscribers** get higher rate limits. **Pay-as-you-go** is also available if you need more.

## Available Models

Models accessible via GitHub Models API include:

| Model | ID for API | Quality |
|-------|-----------|---------|
| GPT-4o | `openai/gpt-4o` | Excellent |
| GPT-4o mini | `openai/gpt-4o-mini` | Good, faster |
| GPT-4.1 | `openai/gpt-4.1` | Excellent |
| Claude Sonnet 4.6 | `anthropic/claude-sonnet-4.6` | Excellent |
| Claude Haiku 4.5 | `anthropic/claude-haiku-4.5` | Good, faster |
| Llama 4 Scout | `meta/llama-4-scout` | Good, open-source |

> Check the full catalog: `GET https://models.github.ai/catalog/models`

## Setup Steps

### 1. Create a GitHub Personal Access Token

1. Go to https://github.com/settings/tokens?type=beta (fine-grained PAT)
2. Click **"Generate new token"**
3. Set a name (e.g., `ai-confluence-pipeline`)
4. Set expiration (90 days or custom)
5. Under **Permissions** → **Account permissions** → set **GitHub Copilot** or **Models** to **Read**
   - If you don't see "Models", use a **classic token** instead: https://github.com/settings/tokens → "Generate new token (classic)" → check the `read:models` scope
6. Click **"Generate token"** and copy it

### 2. Configure .env

```bash
cp .env.example .env
```

Edit `.env`:
```env
# AI Provider
AI_PROVIDER=github-models
GITHUB_TOKEN=github_pat_xxxxx        # Your PAT from step 1
AI_MODEL=openai/gpt-4o               # Or anthropic/claude-sonnet-4.6

# Leave ANTHROPIC_API_KEY and OPENAI_API_KEY empty
ANTHROPIC_API_KEY=
OPENAI_API_KEY=
```

### 3. Update the n8n Workflow

The default workflow calls the Anthropic API. To use GitHub Models instead, update the **"Call Claude API"** node:

**URL:** Change to:
```
https://models.github.ai/inference/chat/completions
```

**Headers:** Replace the Anthropic headers with:
```
Authorization: Bearer {{ $env.GITHUB_TOKEN }}
Content-Type: application/json
Accept: application/vnd.github+json
X-GitHub-Api-Version: 2026-03-10
```

**Body:** Change from Anthropic format to OpenAI-compatible format:
```json
{
  "model": "{{ $env.AI_MODEL }}",
  "messages": [
    {
      "role": "user",
      "content": "Your prompt here..."
    }
  ],
  "max_tokens": 4096
}
```

**Parse response:** Update the "Parse AI Response" node. The GitHub Models response uses OpenAI format:
```javascript
// GitHub Models / OpenAI format
const response = $input.first().json;
const content = response.choices[0].message.content;
// (rest of parsing logic stays the same)
```

### 4. Alternative: Import the GitHub Models Workflow

Instead of modifying the default workflow, import the pre-configured variant:

```
workflows/github-models-pipeline.json
```

This workflow is identical to the default but pre-configured for GitHub Models API.

## Comparison: GitHub Models vs Paid API Keys

| | GitHub Models (Free) | Anthropic API | OpenAI API |
|---|---|---|---|
| **Cost** | Free | ~$3-15 per million tokens | ~$2.50-10 per million tokens |
| **Rate limit** | 50 req/day (high tier) | Unlimited (with billing) | Unlimited (with billing) |
| **Setup** | GitHub PAT only | API key + billing | API key + billing |
| **Models** | GPT-4o, Claude, Llama, etc. | Claude only | GPT only |
| **Best for** | Low volume (<50 analyses/day) | High volume, best Claude models | High volume, best GPT models |
| **Response time** | Slightly slower | Fast | Fast |

## Troubleshooting

### "403 Forbidden" or "401 Unauthorized"
- Verify your PAT has the `models:read` scope (or `read:models` for classic tokens)
- Make sure the PAT hasn't expired
- Check that the `Authorization: Bearer` header includes the full token

### "429 Too Many Requests"
- You've hit the rate limit. Wait until the next reset window (usually resets per-minute and per-day)
- Switch to a lower-tier model (e.g., `openai/gpt-4o-mini`) for higher limits
- Consider upgrading to pay-as-you-go if you need more

### Response format differs from expected
- GitHub Models uses OpenAI-compatible response format (`choices[0].message.content`), not Anthropic format (`content[0].text`)
- Make sure you updated the "Parse AI Response" node

## Sources

- [GitHub Models REST API — Inference](https://docs.github.com/en/rest/models/inference)
- [GitHub Models Billing & Rate Limits](https://docs.github.com/billing/managing-billing-for-your-products/about-billing-for-github-models)
- [GitHub Models Quickstart](https://docs.github.com/en/github-models/quickstart)
- [Prototyping with AI Models](https://docs.github.com/github-models/prototyping-with-ai-models)
