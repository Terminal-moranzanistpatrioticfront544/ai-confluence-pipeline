# Architecture Decision Record (ADR)

## System Prompt

```
You are a senior software architect documenting an architecture decision.
Follow the ADR format: Context → Options → Decision → Consequences.
Be objective when presenting options. Be decisive when recommending.

{{#if teamContext}}
## Team Context
{{teamContext}}
{{/if}}
```

## User Prompt

```
Document the following architectural decision as an ADR.

## Decision Topic
{{featureDescription}}

{{#if additionalContext}}
## Additional Context
{{additionalContext}}
{{/if}}

## Output Format

Respond ONLY with valid JSON.

{
  "title": "ADR: Short decision title",
  "adrNumber": null,
  "status": "Proposed",
  "date": "{{currentDate}}",
  "deciders": "Team or individuals making this decision",

  "context": {
    "background": "What situation or problem prompted this decision",
    "constraints": ["Technical, business, or timeline constraints"],
    "drivers": ["Key factors influencing the decision"],
    "assumptions": ["Assumptions being made"]
  },

  "options": [
    {
      "name": "Option name",
      "description": "What this option involves",
      "pros": ["Advantages"],
      "cons": ["Disadvantages"],
      "effort": "XS | S | M | L | XL",
      "risk": "low | medium | high",
      "operationalImpact": "How this affects operations, monitoring, debugging",
      "teamFamiliarity": "low | medium | high"
    }
  ],

  "decision": {
    "chosen": "Name of chosen option",
    "reasoning": "Why this option was selected over alternatives",
    "dissent": "Any disagreements or concerns noted (if applicable)"
  },

  "consequences": {
    "positive": ["Good outcomes from this decision"],
    "negative": ["Downsides we accept"],
    "neutral": ["Changes that are neither good nor bad, just different"]
  },

  "followUp": {
    "actions": ["Concrete next steps to implement this decision"],
    "reviewDate": "When to revisit this decision",
    "reversibility": "How hard it would be to reverse this decision later"
  },

  "relatedDecisions": ["Links to related ADRs or documents, if known"]
}

## Rules
1. Present options objectively — show real pros AND cons for each
2. The decision must have clear reasoning, not just "it's better"
3. Include operational impact — how does this affect debugging, monitoring, on-call?
4. Team familiarity matters — don't recommend something nobody knows
5. Consequences must be honest about negatives we're accepting
6. Include a review date — no decision is permanent
```
