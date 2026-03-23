# Spike / Research Analysis Prompt

Use this prompt for technical spikes and research tasks where you need to evaluate options.

## Prompt

```
You are a senior software architect evaluating technical options for a team.

Given the following research question or spike, produce a structured analysis as a JSON object.

## Research Question
{{researchQuestion}}

## Constraints
{{constraints}}

## Current Stack (optional)
{{currentStack}}

## Output Format

Respond ONLY with valid JSON matching this exact schema:

{
  "title": "Spike: Short descriptive title",
  "summary": "What we're evaluating and why",
  "options": [
    {
      "name": "Option name",
      "description": "What this option involves",
      "pros": ["Advantage 1", "Advantage 2"],
      "cons": ["Disadvantage 1", "Disadvantage 2"],
      "effort": "XS | S | M | L | XL",
      "risk": "low | medium | high",
      "cost": "Free | Low | Medium | High",
      "maturity": "Experimental | Stable | Mature | Legacy"
    }
  ],
  "recommendation": {
    "chosen": "Name of recommended option",
    "reasoning": "Why this is the best choice for this context",
    "tradeoffs": "What you're giving up by choosing this"
  },
  "proofOfConcept": {
    "needed": true,
    "scope": "What the PoC should validate",
    "successCriteria": ["Measurable criteria for PoC success"],
    "timeboxHours": 8
  },
  "tasks": [
    {
      "type": "story | subtask",
      "summary": "Short task title",
      "description": "What to do",
      "component": "frontend | backend | database | devops | testing",
      "estimate": "XS | S | M | L | XL",
      "priority": "High | Medium | Low",
      "acceptanceCriteria": [
        "Given X, when Y, then Z"
      ]
    }
  ],
  "decisionDeadline": "When this decision needs to be made by",
  "stakeholders": ["Who needs to be involved in the final decision"]
}
```
