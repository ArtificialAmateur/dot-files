---
name: review-notes
description: Use when the user invokes /review-notes to curate, merge, and cross-link unreviewed daily log content into polished notes
user_invocable: true
---

# Review Notes

Curate unreviewed daily log content into polished, cross-linked notes.

## Arguments

Optional time range argument. Examples:
- `/review-notes` — default: last 2 weeks
- `/review-notes last month`
- `/review-notes 2024-09-01 to 2024-09-30`

## Workflow

### Step 1: Scan for unreviewed content

Two scans are required — run both, not just the first:

1. **Explicit unreviewed:** `rg '\[reviewed:: no\]' ~/Documents/work_logs/daily/`
2. **Missing field entirely:** Find files with no `[reviewed::]` field
   at all. Get all daily files via glob, get files with the field via
   `rg '\[reviewed::' ~/Documents/work_logs/daily/ -l`, diff the two
   lists. These are legacy files that predate the tagging convention
   and MUST be included in the review — they are not optional.

Then read those files to extract the full section content.

### Step 2: Group by project/topic

Group unreviewed sections by:
1. Project references — `[[wiki links]]` to project codenames
2. Topic similarity — sections discussing the same technique, tool,
   or concept across different days
3. Ungrouped — sections that don't clearly belong to a project or
   topic

### Step 3: Chase the link graph

For each group, before proposing any action:

1. Identify all existing notes in `~/Documents/work_logs/notes/` that
   relate to this group (by wiki links, tags, and content)
2. Read those notes to understand what's already captured
3. Check which MOCs reference these notes
4. Use this context to decide: merge into existing note, create new
   note, or skip

### Step 4: Propose actions

For each group, propose ONE of these actions to the user:

**Merge into existing topic note:** "These N sections across M days
discuss [topic]. Proposed addition to `notes/[Title].md`:" followed
by the consolidated content.

**Create new topic note:** "You discussed [topic] on N days but no
topic note exists. Proposed `notes/[Title].md`:" followed by the
complete note with frontmatter.

**Update project note:** "[Codename] has N unreviewed sessions.
Proposed updates to What's Been Tried and Open Questions sections."

**Promote to guide:** "This session was a walkthrough of [process].
Proposed `notes/Guide - [Title].md`:" followed by the guide note.

**No action needed:** "These N sections are routine work with no
extractable knowledge. Mark as reviewed?"

Show the full proposed content for each action. Wait for user approval
before proceeding.

### Step 5: Execute approved actions

For each approved proposal:
1. Write the changes to the destination note
2. Overwrite `[reviewed:: no]` with `[reviewed:: YYYY-MM-DD]` in each
   source section in the daily logs (if section has no `[reviewed::]`
   field, add `[reviewed:: YYYY-MM-DD]` at the end of the section)
3. Add backlinks between the source daily logs and destination notes
   where appropriate

### Step 6: Update MOCs and cross-links

After all proposals are processed:
1. Check if any new notes were created that belong in an existing MOC
   (in `~/Documents/work_logs/notes/MOCs/`)
2. Check if any existing notes should now link to each other based on
   the new content
3. Propose MOC additions and cross-link updates to the user

## Output Format

Present a summary at the end:
- Sections reviewed: N
- Notes created: N
- Notes updated: N
- MOC updates: N
- Sections marked reviewed without extraction: N

## Inline Field Reference

Overwrite in daily log sections after processing:
```
[reviewed:: no]          →  [reviewed:: YYYY-MM-DD]
```

If no `[reviewed::]` field exists, add `[reviewed:: YYYY-MM-DD]` at
the end of the section.

## Dataview Inline Field Placement

**Blank line rule:** Always insert a blank line before `[reviewed::]`
(and any other inline field) if the preceding line is a list item
(`- `, `- [x]`, `1.`, etc.). Dataview scopes inline fields
immediately after list items as list-item-level rather than
page-level. Without the blank line, the field is invisible to
page-level queries like `WHERE !reviewed`, causing files to appear
permanently unreviewed in dashboards.

## Tag Taxonomy

Only use tags defined in `~/Documents/work_logs/CLAUDE.md`.
