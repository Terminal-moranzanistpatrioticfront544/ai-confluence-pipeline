# Large Refactoring — Before/After Analysis

## System Prompt

```
You are a senior software architect planning a major code refactoring.
Your output will create a Confluence analysis page and Jira tasks automatically.
Refactors must preserve behavior — the system should work identically before and after.

{{#if teamContext}}
## Team Context
{{teamContext}}
{{/if}}
```

## User Prompt

```
Analyze the following refactoring need and produce a structured plan.

## Refactoring Description
{{featureDescription}}

{{#if additionalContext}}
## Additional Context
{{additionalContext}}
{{/if}}

## Output Format

Respond ONLY with valid JSON.

{
  "title": "Refactor: Short descriptive title",
  "summary": "What's being refactored and why (business justification, not just 'cleaner code')",

  "currentState": {
    "description": "How the code/architecture currently works",
    "problems": [
      {
        "description": "Specific problem with the current approach",
        "impact": "How this problem affects development or operations",
        "frequency": "How often this causes pain"
      }
    ],
    "affectedFiles": "Approximate number and location of files affected",
    "codeSmells": ["Specific code smells or anti-patterns present"]
  },

  "targetState": {
    "description": "How the code/architecture should look after refactoring",
    "pattern": "Design pattern or principle being applied",
    "benefits": [
      {
        "description": "Specific benefit",
        "measurable": "How to verify this benefit was achieved"
      }
    ]
  },

  "beforeAfter": [
    {
      "aspect": "Code organization | API surface | Data flow | Error handling | Testing",
      "before": "How it works now",
      "after": "How it will work after"
    }
  ],

  "migrationSteps": [
    {
      "order": 1,
      "description": "What to do in this step",
      "safetyCheck": "How to verify nothing broke after this step",
      "reversible": true
    }
  ],

  "tasks": [
    {
      "type": "story",
      "summary": "Task title",
      "description": "What to do",
      "component": "frontend | backend | database | devops | testing",
      "estimate": "XS | S | M | L | XL",
      "priority": "Critical | High | Medium | Low",
      "dependencies": [],
      "acceptanceCriteria": [
        "Given [precondition], when [action], then [expected result]",
        "All existing tests pass without modification (behavior preserved)"
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

  "testingStrategy": {
    "existingTests": "What existing tests provide safety net",
    "newTestsNeeded": ["Tests to add before refactoring begins"],
    "characterizationTests": ["Tests that capture current behavior to detect regressions"],
    "verificationApproach": "How to verify the refactor preserved all behavior"
  },

  "outOfScope": ["Changes that should NOT be mixed into this refactor"],
  "estimatedComplexity": "low | medium | high",
  "suggestedApproach": "Recommended strategy (e.g., bottom-up, inside-out, extract-then-inline)"
}

## Rules
1. Every step must preserve existing behavior — no functional changes mixed in
2. Include characterization tests to lock down current behavior before touching code
3. Each task should be a safe, independently mergeable PR
4. Out of scope section is critical — prevent scope creep
5. Before/after comparisons should be concrete, not abstract
6. First task should always be "add missing test coverage for current behavior"
```
