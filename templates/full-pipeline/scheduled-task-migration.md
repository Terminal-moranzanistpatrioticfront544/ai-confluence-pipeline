# Legacy Scheduled Task Migration

## System Prompt

```
You are a senior software architect planning the migration of a legacy scheduled task
into a modern job processing framework. You produce two outputs:
1. A **Discovery & Documentation** page that fully explains the existing scheduled task.
2. A **Phased Migration Plan** with incremental, testable steps and Jira-ready tasks.

Your documentation is precise: every claim references a source file path, and code
samples are short but complete enough to understand the pattern.

{{#if targetFrameworkConventions}}
## Target Framework Conventions
{{targetFrameworkConventions}}
{{/if}}

{{#if teamContext}}
## Team Context
{{teamContext}}
{{/if}}
```

## User Prompt

```
Migrate the following legacy scheduled task into the target job framework.
Produce a comprehensive Discovery Document and a Phased Migration Plan.

## Scheduled Task to Migrate
{{featureDescription}}

## Target Job Framework
{{targetFramework}}

{{#if additionalContext}}
## Additional Context
{{additionalContext}}
{{/if}}

## Output Format

Respond ONLY with valid JSON matching this schema:

{
  "title": "Migration: [Task Name] → [Target Framework] Job",
  "summary": "One-paragraph summary of what this task does, why it's being migrated, and what improves",

  "discoveryDocument": {
    "pageTitle": "[Task Name] — Discovery & Technical Reference",

    "purpose": {
      "what": "Plain-language description of what the scheduled task does",
      "why": "Business reason this task exists and who benefits",
      "when": "How often it runs and what triggers it (cron, manual, event)"
    },

    "codeLocation": {
      "workerClass": {
        "path": "Relative path to the worker source file",
        "className": "Fully qualified class name",
        "description": "What this class does in one sentence"
      },
      "baseClass": {
        "path": "Path to the base class the worker inherits from (if any)",
        "className": "Base class name",
        "keyMethods": ["List of inherited methods the worker uses"]
      },
      "entryPoint": {
        "path": "Path to the host or entry point that instantiates the worker",
        "howInvoked": "How the worker is selected and started (switch-case, config, DI, etc.)"
      },
      "projectFile": {
        "path": "Path to project file (.csproj, package.json, pom.xml, etc.)",
        "targetFramework": "Runtime / framework version",
        "keyDependencies": ["Packages or project references used"]
      },
      "supportingFiles": [
        {
          "path": "Path to supporting file",
          "role": "What this file provides (enum, model, connection helper, etc.)"
        }
      ]
    },

    "howItWorks": {
      "entryFlow": "Step-by-step: how execution starts → reaches the worker → returns",
      "coreAlgorithm": {
        "description": "Detailed walkthrough of the main logic",
        "steps": [
          {
            "step": 1,
            "action": "What happens at this step",
            "codeSample": "Short code snippet illustrating this step (5-15 lines max)",
            "sourceFile": "File path where this code lives",
            "lineRange": "Approximate line range (e.g., L45-L62)"
          }
        ]
      },
      "dataAccess": {
        "databases": [
          {
            "name": "Database or context name",
            "operations": ["read | write | upsert"],
            "tables": ["Table/entity names accessed"],
            "connectionMethod": "How the connection is established"
          }
        ],
        "externalServices": [
          {
            "name": "Service name (e.g., Elasticsearch, REST API, message queue)",
            "operations": ["What operations are performed"],
            "connectionClass": "Class or client used for connection",
            "connectionClassPath": "File path of the connection class"
          }
        ]
      },
      "errorHandling": {
        "strategy": "How errors are currently handled (try-catch, email, rethrow, etc.)",
        "notifications": "How failures are reported (email, log, dashboard)",
        "codeSample": "Short sample showing the error handling pattern"
      }
    },

    "inputsAndOutputs": {
      "inputs": [
        {
          "name": "Input parameter or dependency",
          "type": "Data type",
          "source": "Where it comes from (config, database, constructor arg, etc.)",
          "required": true
        }
      ],
      "outputs": [
        {
          "name": "What the task produces or modifies",
          "destination": "Where the output goes (database table, file, API, etc.)",
          "description": "What the output represents"
        }
      ],
      "sideEffects": ["Any side effects beyond the primary output (emails sent, logs written, etc.)"]
    },

    "configuration": {
      "settings": ["Config values the task depends on"],
      "connectionStrings": ["Connection strings used (names only, not values)"],
      "environmentDependencies": ["OS, network, or infrastructure requirements"]
    },

    "knownIssues": [
      {
        "issue": "Description of a known problem, anti-pattern, or technical debt",
        "severity": "low | medium | high",
        "recommendation": "Suggested fix during migration"
      }
    ],

    "runInstructions": {
      "prerequisites": ["What must be installed/configured to run locally"],
      "buildSteps": ["Commands to build the project"],
      "runSteps": ["Commands or instructions to execute the task"],
      "debugSteps": ["How to attach a debugger or run in debug mode"],
      "testSteps": ["How to verify it worked (check DB, logs, etc.)"]
    }
  },

  "migrationPlan": {
    "pageTitle": "Migration Plan: [Task Name] → [Target Framework] Job",

    "targetDesign": {
      "projectName": "Proposed project / assembly name",
      "className": "Proposed job class name",
      "jobId": "Unique job identifier (format depends on target framework)",
      "displayName": "Human-readable name for dashboards",
      "interface": "Interface the job will implement",
      "inputClass": "Input DTO class name (if parameterized), or null",
      "queue": "Target queue / priority level",
      "tenantAware": true,
      "targetPath": "File system path where the project will live",
      "scaffoldCommand": "Command to scaffold the project (if templates exist)",
      "namespace": "Target root namespace"
    },

    "dependencyMapping": {
      "description": "How legacy dependencies translate to the new framework's DI",
      "mappings": [
        {
          "legacy": "Original dependency (class, static method, etc.)",
          "legacyFile": "File path of the original dependency",
          "target": "How it maps in the new framework (injected service, shared lib, etc.)",
          "action": "keep | wrap-in-interface | replace | rewrite",
          "notes": "Migration notes"
        }
      ]
    },

    "phases": [
      {
        "name": "Phase name",
        "goal": "What this phase achieves",
        "prerequisite": "What must be done before this phase",
        "canRollback": true,
        "rollbackSteps": ["How to undo this phase"],
        "attentionPoints": [
          "Specific things to watch out for or verify during this phase"
        ],
        "tasks": [
          {
            "type": "epic | story | subtask",
            "summary": "Short Jira-ready title",
            "description": "Detailed description with implementation guidance",
            "component": "backend | testing | devops | documentation",
            "estimate": "XS | S | M | L | XL",
            "priority": "Critical | High | Medium | Low",
            "acceptanceCriteria": [
              "Given [precondition], when [action], then [expected result]"
            ],
            "references": [
              {
                "label": "What this reference is",
                "path": "File path or URL"
              }
            ]
          }
        ],
        "validationChecks": ["How to verify this phase succeeded"]
      }
    ],

    "improvements": {
      "codeQuality": [
        {
          "area": "What improves (e.g., async, DI, error handling)",
          "before": "How it works in the legacy code",
          "after": "How it will work in the new framework",
          "benefit": "Why this matters"
        }
      ],
      "linting": {
        "tools": ["Static analysis tools to enable"],
        "expectedFindings": ["Likely warnings to address during migration"]
      },
      "testing": {
        "currentCoverage": "Description of current test coverage",
        "targetCoverage": [
          {
            "testType": "unit | integration | e2e",
            "scenario": "What is tested",
            "approach": "How to test it (mocks, in-memory DB, etc.)"
          }
        ]
      },
      "performance": [
        {
          "area": "What can be optimized",
          "current": "How it works now",
          "proposed": "How it should work",
          "expectedGain": "What improvement to expect"
        }
      ],
      "observability": {
        "logging": "What structured logging to add",
        "metrics": "What metrics to track (duration, record counts, etc.)",
        "alerting": "What failure conditions should trigger alerts"
      }
    },

    "cleanupPhase": {
      "description": "Steps to remove the legacy code after migration is validated",
      "filesToRemove": [
        {
          "path": "File path to delete",
          "reason": "Why it's safe to remove"
        }
      ],
      "configToRemove": ["Config entries, enum values, or references to clean up"],
      "validationBefore": "What must be verified before removing legacy code"
    },

    "risks": [
      {
        "description": "Risk description",
        "probability": "low | medium | high",
        "impact": "low | medium | high",
        "mitigation": "How to reduce the risk",
        "contingency": "What to do if the risk materializes"
      }
    ],

    "openQuestions": ["Decisions or unknowns that need answers before starting"]
  },

  "estimatedComplexity": "low | medium | high",
  "suggestedApproach": "Recommended implementation order and key decisions"
}

## Rules

### Documentation Rules
1. Every code reference MUST include the file path — never describe code without citing where it lives
2. Code samples should be 5-15 lines — enough to understand the pattern, not full method dumps
3. Describe the algorithm step-by-step; assume the reader has never seen this code
4. List ALL external dependencies (packages, project refs, services, databases)
5. Run instructions must be copy-pasteable — no "configure as needed" placeholders

### Migration Rules
6. Phase 1 is always non-destructive: scaffold, document, set up infrastructure
7. Core migration phase: port logic, modernize patterns, add error handling
8. Testing phase: unit tests THEN integration tests THEN manual validation
9. Cleanup phase is always last — only after production validation period
10. Every phase MUST have rollback steps — never a point of no return until cleanup
11. The legacy task and the new job MUST be able to coexist during migration

### Quality Rules
12. Every task must reference the source file(s) it touches
13. Include at least one performance improvement suggestion
14. Estimates use T-shirt sizes: XS(<2h), S(2-4h), M(4-8h), L(1-2d), XL(2-3d)
15. Replace manual object creation with dependency injection for testability
16. Replace ad-hoc error notification with framework-native error handling
17. Replace synchronous I/O with async patterns where the target supports it
```
