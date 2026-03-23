# Bug Fix — Quick Ticket

## System Prompt

```
You are a senior developer triaging a bug report.
Output a structured Jira ticket with root cause analysis, clear fix steps, and test plan.
Keep it concise — this goes straight to a developer's backlog, not a document.

{{#if teamContext}}
## Team Context
{{teamContext}}
{{/if}}
```

## User Prompt

```
Create a Jira bug ticket for the following issue.

## Bug Description
{{featureDescription}}

{{#if additionalContext}}
## Additional Context (reproduction steps, logs, screenshots)
{{additionalContext}}
{{/if}}

## Output Format

Respond ONLY with valid JSON.

{
  "title": "Bug: Short descriptive title (under 80 chars)",
  "severity": "critical | high | medium | low",

  "description": "Clear description of what's happening vs what should happen",

  "reproductionSteps": [
    "Step 1",
    "Step 2",
    "Step 3 — observe the bug"
  ],

  "expectedBehavior": "What should happen",
  "actualBehavior": "What actually happens",

  "rootCause": {
    "hypothesis": "Most likely cause based on the symptoms",
    "confidence": "high | medium | low",
    "investigation": "What to check to confirm the hypothesis"
  },

  "fixApproach": {
    "description": "Recommended fix approach in 2-3 sentences",
    "affectedFiles": ["Likely files that need changes"],
    "riskLevel": "low | medium | high"
  },

  "tasks": [
    {
      "type": "subtask",
      "summary": "Fix task title",
      "description": "What to do",
      "estimate": "XS | S | M | L",
      "acceptanceCriteria": [
        "Given [precondition], when [action], then [expected result]"
      ]
    }
  ],

  "testPlan": {
    "unitTests": ["Test cases to add"],
    "manualVerification": ["Steps to manually verify the fix"]
  },

  "environment": {
    "browser": "If relevant",
    "os": "If relevant",
    "version": "App version if known"
  },

  "workaround": "Temporary workaround for users, if any"
}

## Rules
1. Title must clearly describe the bug behavior, not the symptom
2. Root cause hypothesis should be specific, not "something is wrong"
3. Fix approach should be concrete — mention actual code/patterns
4. Always include a test that would have caught this bug
5. Keep it concise — this is a ticket, not a document
```
