---
name: stage-plan
description: Plan a new implementation stage for any expert plugin. Produces design doc + TDD implementation plan following the two-document pattern.
user_invocable: true
---

# Stage Planning

Create a design doc and TDD implementation plan for a new stage of an
expert plugin. This skill generalizes the two-document pattern used
across all experts in the vulnerability research system.

## Step 1: Identify context

Determine which expert you're planning for. If not obvious from
conversation context, ask with AskUserQuestion:
- Which expert? (linux-expert, exploit-expert, reversing-expert,
  fuzzing-expert)
- Which stage number?
- Brief goal (one sentence)

## Step 2: Read current state

Read these files in order, stopping when you have enough context:

1. `PROGRESS.md` in the expert's root — current state, completed
   stages, test counts, known issues
2. `STAGES.md` — scope and task list for the target stage
3. Previous stage's **design doc only** (never load completed plans)
4. Existing codebase files the new stage interfaces with
5. Master design doc **by line offset only** for specific interface
   definitions (schema, tool specs). Never load wholesale.

## Step 3: Write design document

Create `docs/plans/<prefix>-stage<N>-design.md` with:

- **Goal** — one sentence
- **Deliverables** — numbered list, each with:
  - File path(s) created/modified
  - Public interface (function signatures, tool parameters)
  - Behavior description
  - Data formats (schemas, config files, JSON shapes)
- **Files created/modified** — summary table (File | Action)
- **Test plan** — bullet list of test categories and coverage

No implementation code in the design doc. Interfaces, data flow,
and decisions only.

## Step 4: Write implementation plan

Create `docs/plans/<prefix>-stage<N>-plan.md` with:

- Header: goal, architecture summary, tech stack, link to design doc
- Directive: `> **For Claude:** REQUIRED SUB-SKILL: Use
  superpowers:executing-plans to implement this plan task-by-task.`
- **Tasks numbered sequentially**, alternating TDD pairs:
  1. Failing tests task — write tests, verify they fail
  2. Implementation task — write code, run tests, run full suite,
     lint, commit
  - Non-test tasks (configs, docs, seed data) get their own tasks
  - Final task: "Update PROGRESS.md and Final Verification"

Each task specifies:
- **Files** — exact paths created or modified
- **Steps** — numbered, with exact commands and expected outcomes
- **Code** — complete code blocks ready to be written verbatim
- **Commit** — exact `git add` and `git commit` commands

## Constraints

- Tasks ordered so each builds on the previous (no forward references)
- Test counts are realistic estimates based on the test code
- Each task is self-contained enough for a subagent to execute
- Total plan should be implementable in one session per task pair
