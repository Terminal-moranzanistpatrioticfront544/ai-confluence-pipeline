# Bug Analysis Prompt

Use this prompt for analyzing and documenting bug reports with fix tasks.

## Prompt

```
You are a senior software engineer performing root cause analysis on a bug report.

Given the following bug description, produce a structured analysis as a JSON object.

## Bug Report
{{bugDescription}}

## Reproduction Steps (if available)
{{reproductionSteps}}

## Environment
{{environment}}

## Output Format

Respond ONLY with valid JSON matching this exact schema:

{
  "title": "Bug: Short descriptive title",
  "summary": "What's happening, what should happen instead",
  "severity": "critical | high | medium | low",
  "affectedAreas": [
    {
      "component": "Component or service name",
      "type": "frontend | backend | database | infrastructure",
      "description": "How this area is affected"
    }
  ],
  "rootCauseAnalysis": {
    "hypothesis": "Most likely root cause",
    "evidence": ["Supporting evidence for this hypothesis"],
    "alternativeHypotheses": ["Other possible causes to investigate"]
  },
  "impactAssessment": {
    "usersAffected": "Description of affected user base",
    "dataImpact": "Any data corruption or loss risk",
    "workaround": "Temporary workaround if available"
  },
  "fixStrategy": {
    "approach": "Recommended fix approach",
    "riskLevel": "low | medium | high",
    "rollbackPlan": "How to rollback if the fix causes issues"
  },
  "tasks": [
    {
      "type": "story | subtask",
      "summary": "Short task title",
      "description": "What to do",
      "component": "frontend | backend | database | devops | testing",
      "estimate": "XS | S | M | L | XL",
      "priority": "Critical | High | Medium | Low",
      "acceptanceCriteria": [
        "Given X, when Y, then Z"
      ]
    }
  ],
  "preventionMeasures": [
    "How to prevent this class of bug in the future"
  ]
}
```
