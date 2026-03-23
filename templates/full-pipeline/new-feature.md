# New Feature — Full Analysis

## System Prompt

```
You are a senior software architect performing technical analysis for a development team.
Your output will be used to create a Confluence documentation page and Jira tickets automatically.

{{#if teamContext}}
## Team Context
{{teamContext}}
{{/if}}
```

## User Prompt

```
Analyze the following feature request and produce a comprehensive technical analysis.

## Feature Description
{{featureDescription}}

{{#if additionalContext}}
## Additional Context
{{additionalContext}}
{{/if}}

## Output Format

Respond ONLY with valid JSON. No markdown fences, no explanation — just the JSON object.

{
  "title": "Short descriptive title (5-8 words)",
  "summary": "2-3 sentence executive summary of what this feature does and why it matters",

  "architecture": {
    "overview": "High-level description of how this feature fits into the existing system",
    "components": [
      {
        "name": "Component or service name",
        "type": "frontend | backend | database | infrastructure | external-service",
        "description": "What this component does in the context of this feature",
        "changes": "Specific additions or modifications needed",
        "isNew": false
      }
    ],
    "dataFlow": "Step-by-step description of how data moves through the system for this feature",
    "diagram": "Mermaid sequence or flowchart diagram syntax (optional, for complex features)"
  },

  "apiContracts": [
    {
      "method": "GET | POST | PUT | PATCH | DELETE",
      "path": "/api/v1/...",
      "description": "What this endpoint does",
      "authentication": "Required | Optional | None",
      "requestBody": { "example": "realistic request payload" },
      "responseBody": { "example": "realistic response payload" },
      "statusCodes": [
        "200 - Success description",
        "400 - Validation error description",
        "404 - Not found description"
      ]
    }
  ],

  "databaseChanges": [
    {
      "type": "new-table | alter-table | new-index | new-enum | migration",
      "entity": "TableOrEntityName",
      "description": "What changes and why",
      "fields": [
        {
          "name": "field_name",
          "type": "varchar(255) | int | boolean | uuid | timestamptz | jsonb",
          "nullable": false,
          "default": null,
          "description": "What this field stores"
        }
      ],
      "indexes": ["Index descriptions if relevant"],
      "relationships": ["Foreign key relationships"]
    }
  ],

  "edgeCases": [
    {
      "scenario": "Specific edge case description",
      "impact": "low | medium | high",
      "mitigation": "How to handle this case",
      "testCase": "How to verify the mitigation works"
    }
  ],

  "securityConsiderations": [
    {
      "concern": "Specific security concern",
      "category": "authentication | authorization | validation | injection | data-exposure | rate-limiting",
      "mitigation": "How to address it"
    }
  ],

  "testingStrategy": {
    "unitTests": [
      { "scenario": "Test description", "component": "What's being tested" }
    ],
    "integrationTests": [
      { "scenario": "Test description", "component": "What's being tested" }
    ],
    "e2eTests": [
      { "scenario": "Test description", "userFlow": "User action sequence" }
    ]
  },

  "tasks": [
    {
      "type": "epic | story | subtask",
      "summary": "Short task title — Jira-ready (under 80 chars)",
      "description": "Detailed description of what needs to be done",
      "component": "frontend | backend | database | devops | testing",
      "estimate": "XS | S | M | L | XL",
      "priority": "Critical | High | Medium | Low",
      "dependencies": [],
      "acceptanceCriteria": [
        "Given [precondition], when [action], then [expected result]"
      ]
    }
  ],

  "risks": [
    {
      "description": "Risk description",
      "probability": "low | medium | high",
      "impact": "low | medium | high",
      "mitigation": "How to reduce the risk"
    }
  ],

  "outOfScope": ["Things that are explicitly NOT part of this feature"],
  "openQuestions": ["Questions that need answers before implementation"],
  "estimatedComplexity": "low | medium | high",
  "suggestedApproach": "Recommended implementation order and strategy (2-3 sentences)"
}

## Rules
1. Be specific to the described feature — no generic boilerplate
2. Tasks should be completable by one developer in 1-3 days max
3. Acceptance criteria in Given/When/Then format for every task
4. API contracts must include realistic example payloads
5. Edge cases should be real failure modes, not theoretical
6. Estimates: XS(<2h), S(2-4h), M(4-8h), L(1-2d), XL(2-3d)
7. First task should always be the database/schema work if applicable
8. Last task should always be E2E testing
```
