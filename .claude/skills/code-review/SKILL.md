---
name: code-review
description: >
  Provides a structured review of code and documentation/prose that evaluates the content using
  metrics followed by an ordered list of actionable improvements.
  Use when user asks to "review this", "code review", "check my documentation", or similar.
---

# Code Review Skill

## Instructions

### Step 1: Identify the relevant changes
Usually this skill should execute within a Git repository.
(If it doesn't, consider all non-hidden files in the working directory as targets for reviewing)

> Prefer a **summary (file list)** first, then inspect files individually to avoid loading large diffs into context.

When on `main`, review only the staged/unstaged changes.
Example:
```bash
git diff --name-status
```

If on another branch, review all changes on that branch (committed/staged/unstaged) that would show up in a merge request to `main`.
Example:
```bash
git diff --name-status $(git merge-base HEAD main)
```

> Note: If `main` does not exist, try `master`.

### Step 2: Review the individual file changes
Read the raw diff for each changed file.
Example:
```bash
git diff $(git merge-base HEAD main) -- <file>
```

You may need to read around the file to understand its role within the repository. As you read, consider the following:
* Its domain - source/test code, documentation/prose, or both
* Its impact on the given metrics for evaluation
* Actionable improvements that could be made

### Step 3: Summarise findings
Given the previously-identified improvements and evaluations, produce a report of the following format:
```
## Code Review: <what is being reviewed>

### Scores

**Clarity:** <score> / 10 - <summary comment>
**Correctness:** <score> / 10 - <summary comment>
**Robustness:** <score> / 10 - <summary comment>
**Testing:** <score> / 10 - <summary comment>

### Improvements

1. [Critical] <description + file:line reference + suggested fix>
2. [High] <description + file:line reference + suggested fix>
3. [Medium] ...
4. [Low / Nitpick] ...

### Final Comments
<anything extra of note>
```

Scores depend on the domain being reviewed. The template shows how to score code.

Improvements should be priority ordered. Give diffs for small changes. 
Commentary is suitable for wide-reaching refactors.







Run a review rated 1–10 per metric, followed by a prioritised, ordered list of
actionable improvements. The numerical rating is not decoration -- it is a known
psychological technique that forces the reviewer into a more objective, structured
evaluation rather than vague impressions. **Always provide scores.**

Start by stating what you are reviewing (files, diff, or branch compared against
which base).

## Domain Detection

Before reviewing, determine whether the review target is **source code**,
**documentation/prose**, or **both**. The metrics, guidelines, and output format
differ significantly between domains. Use the reference files in the
`references/` directory as appropriate.

- If the target contains code (`.py`, `.ts`, `.go`, `.rs`, etc.), run a **code
  review**.
- If the target contains documentation (`.md`, API docs, README, release notes),
  run a **documentation review**.
- If the PR contains both, run both reviews sequentially.

---

## Part 1: Code Review

When reviewing source code, load the guidelines from:
- `references/solid-principles.md`
- `references/naming-guidelines.md`
- `references/documentation-guidelines.md`

### Scoring Template

Rate the code **1–10** on each metric. A score of 1 is terrible, 10 is excellent.
Be honest and strict -- a 7 is good, not exemplary.

After the scores, provide a **prioritised, ordered list of actionable improvements**
ranked from most impactful to least. Each item must be concrete and actionable.

### Output Format -- Code Review

```
## Code Review: <what is being reviewed>

### Scores

| Metric | Score (1-10) |
|--------|:-----------:|
| Clarity | <score> |
| Correctness | <score> |
| Robustness | <score> |
| Testing | <score> |

### Actionable Improvements (prioritised)

1. [Critical] <description + file:line reference + suggested fix>
2. [High] <description + file:line reference + suggested fix>
3. [Medium] ...
4. [Low / Nitpick] ...
```

### Code Review Metrics

**Clarity (1-10):** How readable and self-explanatory is the code? Could a
reasonable developer understand the intent without hunting through other files or
asking someone?

**Correctness (1-10):** Does the code achieve its intended purpose without bugs or
logical issues? Are edge cases and failure modes handled?

**Robustness (1-10):** How well does it handle the unexpected? Error handling, edge
cases, input validation, graceful degradation, and resistance to future changes.

**Testing (1-10):** Is new or modified behaviour covered? For repos with test suites,
are there obvious gaps? Note: this metric does **not** apply when the codebase has
no test framework in place.

### Evaluation Guidelines

The metrics above are evaluated against the guidelines in the `references/` directory.
Key points to check:

- **SOLID principles** -- Refer to `references/solid-principles.md` for definitions
  and what each principle means in practice. Rate how well these are followed.
- **Naming** -- Refer to `references/naming-guidelines.md`. Flag one-letter variables
  and obscure abbreviations unless there is a strong convention.
- **Comments & docstrings** -- Refer to `references/documentation-guidelines.md`.
  Check that the code is self-documenting, comments explain *why* not *what*, and
  docstrings are brief summaries.

---

## Part 2: Documentation / Prose Review

When reviewing documentation, load the metrics from
`references/doc-review-metrics.md`.

### Scoring Template

Rate the documentation **1–10** on each metric.

After the scores, provide a **prioritised, ordered list of actionable improvements**
ranked from most impactful to least. Each item must specify what to fix and how.

### Output Format -- Documentation Review

```
## Documentation Review: <what is being reviewed>

### Scores

| Metric | Score (1-10) |
|--------|:-----------:|
| Precision | <score> |
| Structure | <score> |
| Clarity | <score> |
| Conciseness | <score> |

### Actionable Improvements (prioritised)

1. [Critical] <description + suggested rewrite>
2. [High] <description + suggested rewrite>
3. [Medium] ...
4. [Low / Nitpick] ...
```

### Documentation Review Metrics

**Precision (1-10):** Language avoids ambiguity. Terms are defined or are idiomatic.
No vague phrases ("soon", "a lot", "properly"). Specificity is the default.

**Structure (1-10):** There is a clear hierarchy with a natural progression. Each
section builds on the previous. No circular references that force the reader to jump
back and forth for context. Information is not needlessly repeated.

**Clarity (1-10):** Ideas are clear on first reading. A reader should not need to
re-read a sentence twice to get it. Jargon is minimised or explained.

**Conciseness (1-10):** Verbosity is minimal. Documentation that is too wordy will
never be read. Every sentence earns its place.

### Evaluation Guidelines

Refer to `references/doc-review-metrics.md` for detailed guidance on each metric,
including examples of good and bad practices. Check that the documentation:

- Avoids ambiguous language, hedging, and filler
- Has a natural reading order from high-level to detail
- Does not repeat the same explanation across sections
- Uses precise terminology consistently

---

## General Rules

- **Scores are mandatory.** Do not skip the scoring table under any circumstances.
- **Actions must be prioritised.** Order matters. The most impactful improvements go
  first. Every item should have a severity label: `[Critical]`, `[High]`,
  `[Medium]`, or `[Low / Nitpick]`.
- **Be specific.** Include file and line references for code issues. Provide suggested
  rewrites for prose issues.
- **Match the user's project conventions.** Load `CLAUDE.md` for any
  project-specific style rules, naming conventions, or patterns.
- **Be constructive.** Criticism should be direct but not condescending. Note
  strengths alongside weaknesses.
