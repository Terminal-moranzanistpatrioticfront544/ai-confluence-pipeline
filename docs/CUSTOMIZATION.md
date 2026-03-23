# Customization Guide

## Prompt Templates

The `prompts/` directory contains templates for different analysis types:

| Template | Use Case |
|----------|----------|
| `technical-analysis.md` | New features — architecture, APIs, tasks |
| `bug-analysis.md` | Bug reports — root cause, fix strategy, tasks |
| `spike-analysis.md` | Research spikes — options comparison, PoC plan |

### Writing Your Own Prompts

The key to good output is **structured JSON schemas**. Always:

1. Define the exact JSON schema you want
2. Use `Respond ONLY with valid JSON` to prevent prose
3. Include field-level descriptions so the AI understands what each field means
4. Provide examples of realistic values (not just "string")

### Injecting Team Context

Add a "System Context" section to your prompts with:
- Your tech stack (languages, frameworks, databases)
- Architecture patterns you follow (microservices, monolith, CQRS)
- Naming conventions (REST paths, database tables, Jira labels)
- Team size and skill distribution

Example:
```
## System Context
- Backend: .NET 9, FastEndpoints, PostgreSQL, RabbitMQ
- Frontend: React Native with Expo
- Architecture: Clean Architecture with CQRS
- API conventions: RESTful, versioned (/api/v1/...)
- Testing: Jest (unit), Playwright (E2E)
- Team: 3 backend, 2 frontend, 1 QA
```

## Confluence Page Format

The "Format for Confluence" node converts JSON to Confluence Storage Format (XHTML).

### Common Confluence Macros

```html
<!-- Code block -->
<ac:structured-macro ac:name="code">
  <ac:parameter ac:name="language">json</ac:parameter>
  <ac:plain-text-body><![CDATA[{ "key": "value" }]]></ac:plain-text-body>
</ac:structured-macro>

<!-- Info panel -->
<ac:structured-macro ac:name="info">
  <ac:rich-text-body><p>Important note here</p></ac:rich-text-body>
</ac:structured-macro>

<!-- Warning panel -->
<ac:structured-macro ac:name="warning">
  <ac:rich-text-body><p>Watch out for this</p></ac:rich-text-body>
</ac:structured-macro>

<!-- Status badge -->
<ac:structured-macro ac:name="status">
  <ac:parameter ac:name="colour">Green</ac:parameter>
  <ac:parameter ac:name="title">Ready</ac:parameter>
</ac:structured-macro>

<!-- Table of contents -->
<ac:structured-macro ac:name="toc" />

<!-- Expand/collapse -->
<ac:structured-macro ac:name="expand">
  <ac:parameter ac:name="title">Click to expand</ac:parameter>
  <ac:rich-text-body><p>Hidden content</p></ac:rich-text-body>
</ac:structured-macro>
```

### Adding a Page Template

To make all generated pages follow your company template:
1. Create a template page in Confluence
2. View its source (Edit → `<>` source view)
3. Copy the structure into the "Format for Confluence" node
4. Replace static content with `${analysis.fieldName}` references

## Jira Configuration

### Custom Fields

If your Jira has custom fields (e.g., Story Points, Sprint), add them in the "Create Jira Issue" node:

```json
{
  "fields": {
    "customfield_10016": 3,
    "customfield_10020": { "id": 123 }
  }
}
```

Find your custom field IDs:
```bash
curl -s -u email:token https://yourcompany.atlassian.net/rest/api/3/field | jq '.[] | select(.custom) | {id, name}'
```

### Epic Linking

To auto-create an Epic and link stories to it:
1. Add a first pass that creates the Epic
2. Capture the Epic key from the response
3. Pass it to story creation via `customfield_10014` (Epic Link)

### Board / Sprint Assignment

To add issues to a specific sprint:
```json
{
  "fields": {
    "customfield_10020": { "id": <sprint-id> }
  }
}
```

## Adding New Workflow Variants

### Confluence-Only (No Jira)

Just call the webhook with `createJiraTasks: false`:
```bash
./scripts/trigger-analysis.sh "Feature description" --no-jira
```

### Batch Processing

Create a CSV/JSON of features and loop through them:
```bash
cat features.json | jq -c '.[]' | while read feature; do
  curl -s -X POST "$WEBHOOK_URL" -H "Content-Type: application/json" -d "$feature"
  sleep 2  # Rate limiting
done
```

### Slack Integration

Add a Slack node after the "Respond to Webhook" node to post a summary:
- Use n8n's built-in Slack node
- Template: "New technical analysis created: [page title](confluence-url) with N tasks"
