# Next Steps & Roadmap

## Vision

Turn this from a single workflow into a **complete tech lead toolkit** — a template-driven system where every type of technical work has a predefined path: what AI analyzes, where docs go, what tickets get created, and how they're structured.

---

## Phase 1: Template Registry (Current Priority)

### The Core Idea

Not every scenario needs the same output. A new feature needs a full Confluence analysis + Jira epic with stories. A bug fix might just need a Jira ticket. An ADR needs only a Confluence page with no tickets at all.

**Template = prompt + output routing + Confluence format + Jira structure**

### Scenario Matrix

| Scenario | Confluence Page | Jira Tickets | Typical Output |
|----------|:-:|:-:|----------------|
| New feature | Yes | Epic + Stories | Architecture, APIs, DB, edge cases, tasks |
| Tech stack migration | Yes | Epic + Stories + Subtasks | Impact analysis, rollout phases, rollback plan |
| Large refactoring | Yes | Epic + Stories | Before/after architecture, migration steps |
| API breaking change | Yes | Stories | Contract diff, consumer impact, migration guide |
| Performance optimization | Yes | Stories | Bottleneck analysis, benchmarks, fix tasks |
| Security audit | Yes | Stories (priority: High) | Vulnerability list, CVSS scores, remediation |
| Infrastructure change | Yes | Stories | Topology changes, cost impact, runbook |
| Architecture Decision Record | Yes | No | Options, decision, consequences |
| Post-mortem / incident report | Yes | Follow-up Stories | Timeline, root cause, action items |
| Bug fix | No | Story or Bug ticket | Root cause, fix approach, test plan |
| Small refactor | No | Story | What to change, why, acceptance criteria |
| Dependency update | No | Story + Subtasks | What's changing, breaking changes, test plan |
| Config change | No | Task | What, where, rollback steps |
| Quick enhancement | No | Story | Requirements, acceptance criteria |
| Tech debt item | No | Story | Current state, desired state, approach |
| Onboarding guide | Yes | No | Setup steps, architecture overview, key contacts |
| Runbook | Yes | No | Step-by-step operational procedures |
| Sprint retrospective summary | Yes | Action item Tasks | What worked, what didn't, action items |

### Template File Structure

```
templates/
├── registry.json                    # Master list of all templates
├── confluence-only/
│   ├── adr.md                       # Architecture Decision Record
│   ├── post-mortem.md               # Incident post-mortem
│   ├── onboarding-guide.md          # Team onboarding
│   └── runbook.md                   # Operational runbook
├── jira-only/
│   ├── bug-fix.md                   # Bug ticket
│   ├── small-refactor.md            # Quick refactor
│   ├── dependency-update.md         # Dep update
│   ├── config-change.md             # Config change
│   ├── quick-enhancement.md         # Small feature
│   └── tech-debt.md                 # Tech debt item
└── full-pipeline/
    ├── new-feature.md               # Feature (current default)
    ├── tech-migration.md            # Stack migration
    ├── large-refactoring.md         # Major refactor
    ├── api-breaking-change.md       # API versioning
    ├── performance-optimization.md  # Perf work
    ├── security-audit.md            # Security findings
    └── infrastructure-change.md     # Infra changes
```

### Registry Schema

```json
{
  "templates": [
    {
      "id": "new-feature",
      "name": "New Feature",
      "description": "Full technical analysis for a new feature",
      "category": "full-pipeline",
      "prompt": "templates/full-pipeline/new-feature.md",
      "output": {
        "confluence": true,
        "jira": true,
        "confluenceTemplate": "standard-analysis",
        "jiraStructure": "epic-with-stories",
        "confluenceLabels": ["technical-analysis", "feature"],
        "jiraLabels": ["feature"],
        "defaultPriority": "Medium"
      }
    },
    {
      "id": "bug-fix",
      "name": "Bug Fix",
      "description": "Quick bug ticket with root cause analysis",
      "category": "jira-only",
      "prompt": "templates/jira-only/bug-fix.md",
      "output": {
        "confluence": false,
        "jira": true,
        "jiraStructure": "single-ticket",
        "jiraIssueType": "Bug",
        "jiraLabels": ["bug"],
        "defaultPriority": "High"
      }
    },
    {
      "id": "adr",
      "name": "Architecture Decision Record",
      "description": "Document an architectural decision with options and rationale",
      "category": "confluence-only",
      "prompt": "templates/confluence-only/adr.md",
      "output": {
        "confluence": true,
        "jira": false,
        "confluenceTemplate": "adr",
        "confluenceLabels": ["adr", "architecture"],
        "confluenceParentPage": "Architecture Decisions"
      }
    }
  ]
}
```

### Updated Trigger API

```bash
# Current (works as before)
./scripts/trigger-analysis.sh "Add notification preferences"

# New: specify template
./scripts/trigger-analysis.sh --template new-feature "Add notification preferences"
./scripts/trigger-analysis.sh --template bug-fix "Login fails when email has + character"
./scripts/trigger-analysis.sh --template adr "Should we migrate from REST to GraphQL?"
./scripts/trigger-analysis.sh --template tech-migration "Migrate from Moment.js to date-fns"

# New: list available templates
./scripts/trigger-analysis.sh --list
```

---

## Phase 2: Confluence Page Templates

### Why This Matters

Raw HTML output from AI looks functional but not polished. Predefined Confluence page templates with proper macros, panels, and layouts make the output look like something a human wrote.

### Template Designs

**Standard Analysis Template**
- Table of contents macro at top
- Info panel with metadata (date, author, complexity, status)
- Expand/collapse sections for detailed API specs
- Status badges for task progress
- "Generated by AI" footer with edit prompt

**ADR Template (Architecture Decision Record)**
- Status badge: Proposed / Accepted / Deprecated / Superseded
- Context section
- Options table (with pros/cons matrix)
- Decision section with rationale
- Consequences section
- Follow-up date

**Post-Mortem Template**
- Severity badge
- Timeline (table with timestamps)
- Impact section with metrics
- Root cause (5 Whys format)
- Action items table with owners and deadlines
- Lessons learned

**Migration Plan Template**
- Phase breakdown (Prepare → Migrate → Validate → Cleanup)
- Rollback plan in a warning panel
- Dependency graph (Mermaid diagram)
- Risk matrix
- Checklist macro for tracking progress

### Implementation

Each template = a JavaScript function in the n8n "Format for Confluence" node that takes the AI JSON output and produces Confluence Storage Format HTML using the right macros and layout.

---

## Phase 3: Jira Structure Templates

### Why This Matters

Different work types have different ticket structures. A feature needs an epic with stories. A migration needs phases as epics with stories under each. A bug just needs one ticket.

### Jira Structures

**`single-ticket`** — One ticket (bug, config change, tech debt)
```
[BUG-123] Login fails with + in email
```

**`epic-with-stories`** — Epic + child stories (features, refactors)
```
[PROJ-100] Epic: User Notification Preferences
  ├── [PROJ-101] Backend: Create notification preferences API
  ├── [PROJ-102] Backend: Add database schema for preferences
  ├── [PROJ-103] Frontend: Build preferences settings page
  ├── [PROJ-104] Backend: Integrate with email/push providers
  └── [PROJ-105] Testing: E2E tests for notification flow
```

**`phased-epics`** — Multiple epics for phased work (migrations, large refactors)
```
[PROJ-200] Epic: Phase 1 — Prepare Migration
  ├── [PROJ-201] Audit current Moment.js usage
  └── [PROJ-202] Set up date-fns alongside Moment.js
[PROJ-210] Epic: Phase 2 — Migrate Core Modules
  ├── [PROJ-211] Migrate date formatting utilities
  └── [PROJ-212] Migrate date arithmetic helpers
[PROJ-220] Epic: Phase 3 — Validate & Cleanup
  ├── [PROJ-221] Update all unit tests
  └── [PROJ-222] Remove Moment.js dependency
```

**`story-with-subtasks`** — Story + subtasks (dependency updates, focused work)
```
[PROJ-300] Update React from v18 to v19
  ├── [PROJ-300-1] Update package.json and resolve peer deps
  ├── [PROJ-300-2] Fix breaking API changes
  ├── [PROJ-300-3] Update unit tests
  └── [PROJ-300-4] Verify E2E test suite
```

---

## Phase 4: Enhanced Features

### Smart Template Selection
AI auto-detects the best template based on the description:
```bash
# No --template flag needed — AI figures it out
./scripts/trigger-analysis.sh "Login is broken when users have a + in their email"
# → Auto-selects: bug-fix template
```

### Confluence Page Updates (Not Just Create)
- Update an existing page instead of creating duplicates
- Version tracking — append "Updated on" sections
- Link related pages together automatically

### Batch Processing
```bash
# Process a backlog of feature ideas from a CSV
./scripts/batch-analyze.sh features.csv --template new-feature

# Process GitHub issues with a specific label
./scripts/analyze-github-issues.sh --repo org/repo --label "needs-analysis"
```

### Team Context Profiles
Store team-specific context that gets injected into every prompt:
```json
{
  "team": "Platform",
  "stack": {
    "backend": ".NET 9, FastEndpoints, PostgreSQL, RabbitMQ",
    "frontend": "React Native, Expo, TypeScript",
    "testing": "Jest (unit), Playwright (E2E)",
    "infra": "Docker, Kubernetes, GitHub Actions"
  },
  "conventions": {
    "api": "RESTful, versioned (/api/v1/...)",
    "branching": "trunk-based with short-lived feature branches",
    "estimation": "T-shirt sizes (XS/S/M/L/XL)"
  },
  "teamSize": "3 backend, 2 frontend, 1 QA"
}
```

### Notification Integrations
- **Slack**: Post summary when analysis is complete
- **Teams**: Same for Microsoft shops
- **Email**: Send digest to stakeholders
- **GitHub**: Comment on issues with analysis link

### Approval Workflow
For high-impact changes (migrations, security, breaking changes):
1. AI generates draft analysis
2. Confluence page created in "Draft" status
3. Slack notification sent to tech lead for review
4. Tech lead approves → Jira tickets created
5. Or rejects → feedback sent back to AI for revision

### Estimation Calibration
Track actual vs estimated effort over time:
- AI estimates: M (4-8h)
- Actual: took 2 days
- System learns and adjusts future estimates for similar work

### CLI Tool
Replace bash/PowerShell scripts with a proper CLI:
```bash
npm install -g ai-confluence-pipeline

# Interactive mode
acp analyze

# Direct mode
acp analyze --template new-feature "Add notification preferences"
acp templates list
acp templates add my-custom-template.md
acp config set confluence.space TECH
acp config set jira.project PROJ
```

---

## Phase 5: Integrations & Ecosystem

### GitHub Integration
- **GitHub Action**: Trigger analysis on issue label
- **PR analysis**: Auto-generate technical docs from PR descriptions
- **Issue sync**: Keep Jira tickets in sync with GitHub Issues

### IDE Integration
- **VS Code extension**: Right-click → "Generate Technical Analysis"
- **Claude Code integration**: `/analyze` slash command that triggers the pipeline

### Dashboard
Simple web UI showing:
- Recent analyses
- Template usage stats
- Estimation accuracy over time
- Link to Confluence pages and Jira boards

---

## Implementation Priority

| Priority | Feature | Effort | Impact |
|----------|---------|--------|--------|
| 1 | Template registry + 5 core templates | M | High |
| 2 | Confluence page templates (3 designs) | M | High |
| 3 | Jira structure templates | S | High |
| 4 | Smart template auto-selection | S | Medium |
| 5 | Team context profiles | S | Medium |
| 6 | Batch processing | M | Medium |
| 7 | Slack notifications | S | Medium |
| 8 | Confluence page updates | M | Medium |
| 9 | Approval workflow | L | Medium |
| 10 | CLI tool | L | High |
| 11 | GitHub Action | M | Medium |
| 12 | Estimation calibration | L | Low |
| 13 | Dashboard | XL | Low |

---

## Contributing

Pick any item from the priority list above and open a PR. The template registry (Priority 1) is the most impactful next step — even adding a single new template helps.

See [CUSTOMIZATION.md](CUSTOMIZATION.md) for how templates and prompts work.
