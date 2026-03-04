---
name: work-log
description: Use when the user invokes /work-log to record what was learned, debugged, or solved during the current session into the daily work log
user_invocable: true
---

# Work Log

Record a summary of the current session's learnings and perform
lightweight knowledge extraction.

## Phase A: Daily Log Entry

1. Review the conversation for questions answered, problems debugged,
   concepts explained, or issues solved
2. Determine today's date and target file:
   `~/Documents/work_logs/daily/YYYY-MM-DD.md`
3. If creating a new file, include frontmatter:
   ```yaml
   ---
   tags:
     - type/daily
   date: YYYY-MM-DD
   projects: []
   ---
   ```
4. If the file already exists, read it first — preserve existing
   frontmatter and content, append new entries after existing content
5. Identify which project notes were discussed and add them as
   `[[wiki links]]` in the frontmatter `projects:` list (avoid
   duplicates)

### Entry format

Each entry uses a `##` heading describing the topic (not a timestamp).
Include:

- **Problem/question** — what was asked or broken
- **Answer/solution** — what fixed it or what the answer was
- **Takeaways** — commands, patterns, or facts worth remembering

End each `##` section with:
```
[extracted:: YYYY-MM-DD]
[reviewed:: no]
```

These Dataview inline fields mark the section as processed but
unreviewed. Use today's date for `extracted`.

**Blank line rule:** If the last line before the inline fields is a
list item (`- `, `- [x]`, `1.`, etc.), insert a blank line between
the list and the inline fields. Dataview scopes inline fields after
list items as list-item-level rather than page-level, which breaks
dashboard queries. This applies everywhere inline fields are added.

Keep entries concise and searchable. One `##` heading per distinct
topic. Use `[[wiki links]]` to reference existing project or topic
notes in the vault.

## Phase B: Lightweight Extraction

After writing the daily log entry, perform these extraction steps:

### 1. Project status update (automatic)

For each project discussed in the session, append a dated one-liner to
the project note's "Current Status" section:

```markdown
**YYYY-MM-DD:** Brief summary of what happened. See [[YYYY-MM-DD]].
```

Read the project note first
(`~/Documents/work_logs/notes/<Codename>.md`). If it doesn't exist,
skip this step — don't create project notes during /work-log.

### 2. Extraction proposals (require approval)

Scan the new daily log content and check if any of these apply:

- **Guide candidate:** The session involved figuring out how to
  install, configure, build, or set up something. Propose creating or
  updating a Guide note.
- **Problem candidate:** A specific bug, error, or issue was solved
  (or identified as open). Propose adding a `## Problem:` subsection
  with Dataview inline fields to the relevant topic or project note.
- **Topic update candidate:** New knowledge about an existing topic
  was learned. Propose appending to the relevant topic note.

For each candidate, show the user:
1. The proposed destination note
2. The proposed content
3. Ask for approval before writing

If the destination note doesn't exist yet, propose creating it with
appropriate frontmatter.

### 3. Frontmatter update

Update the daily log's `projects:` frontmatter field with any project
codenames referenced in the session.

## Tag Taxonomy

Only use tags defined in `~/Documents/work_logs/CLAUDE.md`. Type tag
`type/daily` is always included for daily logs. Add domain tags only
when the session clearly involves those topics.

## Inline Field Reference

```
[extracted:: YYYY-MM-DD]     # Marks section as captured by /work-log
[reviewed:: no]              # Marks section as unreviewed
[problem:: description]      # Problem tracking in topic/project notes
[status:: open|solved|wontfix|abandoned]
[device:: device name]       # Optional, for problem sections
[kernel:: version]           # Optional, for problem sections
```
