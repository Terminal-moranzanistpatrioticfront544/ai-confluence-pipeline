// =============================================================================
// Custom Company Prompts (PRIVATE — gitignored, never committed)
// =============================================================================
//
// To use:
//   1. Copy this file to: custom-prompts/custom-prompts.js
//   2. Add your company-specific templates below
//   3. Refresh trigger.html — your templates appear in the dropdown
//
// Each template needs:
//   id:          Unique identifier (kebab-case)
//   name:        Display name in dropdown
//   description: One-line description shown below the dropdown
//   category:    Group label in dropdown (e.g., your company name)
//   role:        AI role instruction (who the AI pretends to be)
//   schema:      Output format instruction (what JSON fields to produce)
//
// The "role" and "schema" are sent directly to the AI as the prompt.
// Your feature description and additional context are injected automatically.
// =============================================================================

// eslint-disable-next-line no-unused-vars
const CUSTOM_PROMPTS = [
  // --- Example: Company-specific migration template ---
  {
    id: 'clearskies-taskron-migration',
    name: 'Taskron Job Migration',
    description: 'Migrate a ClearSkies scheduled task to a Taskron job following company guidelines',
    category: 'ClearSkies Platform',
    role: 'You are a senior ClearSkies platform engineer migrating legacy scheduled tasks to the Taskron job framework. You follow ClearSkies coding standards, use the company DI container, and produce Taskron-compatible job classes.',
    schema: `Produce JSON with:
      title, summary,
      discoveryDocument (purpose, codeLocation with file paths, howItWorks with algorithm steps each referencing source files, dataAccess, errorHandling, configuration, knownIssues),
      migrationPlan (
        targetDesign with projectName/className/jobId/interface/targetPath set to ClearSkiesPlatform/Backend/DataCenter/Engines,
        dependencyMapping with legacy-to-new mappings,
        phases each with tasks following Taskron guidelines including linters and unit tests,
        improvements for code quality/testing/observability,
        cleanupPhase
      ),
      estimatedComplexity, suggestedApproach.
      Every code reference MUST include the file path.`
  },

  // --- Example: Company-specific code review template ---
  // {
  //   id: 'company-code-review',
  //   name: 'Code Review Checklist',
  //   description: 'Generate a code review checklist based on company standards',
  //   category: 'My Company',
  //   role: 'You are a senior developer performing a code review following company coding standards.',
  //   schema: 'Produce JSON with: title, summary, findings (each with file, line, severity, description, suggestion), positiveAspects, overallScore (1-10), recommendation (approve|request-changes|reject).'
  // },

  // --- Example: Onboarding document ---
  // {
  //   id: 'company-onboarding',
  //   name: 'Service Onboarding Doc',
  //   description: 'Generate onboarding documentation for a service new developers need to learn',
  //   category: 'My Company',
  //   role: 'You are a senior engineer writing onboarding documentation for new team members.',
  //   schema: 'Produce JSON with: title, summary, architecture (overview, keyComponents, dataFlow), gettingStarted (prerequisites, setupSteps, runLocally), keyFiles (path, purpose for each important file), commonTasks (task, howTo for each), debugging (commonIssues, logLocations, tools), contacts (role, name, when to reach out).'
  // },
];
