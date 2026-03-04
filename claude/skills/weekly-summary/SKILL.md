---
name: weekly-summary
description: Use when the user invokes /weekly-summary to generate a weekly summary from daily work logs
user_invocable: true
---

# Weekly Summary

Generate a weekly summary from daily work logs and project status.

## Workflow

1. Determine the target week:
   - If the user specifies a date or week number, use that
   - Default: the last 7 calendar days ending yesterday
2. Calculate the ISO week number (YYYY-Www) for the target week
3. Read all daily logs in `~/Documents/work_logs/daily/` that fall
   within the target week (Monday through Friday)
4. Read project notes in `~/Documents/work_logs/notes/` that have
   `type/project` tag — check their "Current Status" sections for
   dated entries from this week
5. Create `~/Documents/work_logs/notes/YYYY-Www.md` with frontmatter:
   ```yaml
   ---
   tags:
     - type/weekly
   date: YYYY-MM-DD
   week: YYYY-Www
   ---
   ```
6. Fill in sections:

### Sections

**Summary** — 2-3 sentence overview of the week.

**Accomplishments** — Completed items, grouped by project using
`[[wiki links]]`. Pull from project note status lines and daily log
content.

**In Progress** — Ongoing work items with current state.

**Blocked** — Anything stalled, with context on why.

**Knowledge Captured This Week** — List new or updated notes created
by /work-log and /review-notes this week:
- New topic notes created
- New guide notes created
- Problems logged (with status)
- Project notes updated

**Unreviewed Backlog** — Count of daily log sections that still lack
`[reviewed::]` fields. If the count is high, note that /review-notes
is overdue. Check by scanning daily logs from the past month for
sections without `[reviewed:: ...]` inline fields.

**Next Week** — Planned focus areas based on in-progress and blocked
items.

## Formatting Rules

- Use bullet points, not paragraphs
- Link to daily logs as `[[YYYY-MM-DD]]` when referencing specific days
- Link to project notes as `[[Codename]]`
- Link to topic/guide notes when referencing knowledge captured
- Keep each bullet to one line — concise, factual
- If a daily log has no frontmatter, still include its entries (group
  under "General" if no project is identifiable)

## Tag Taxonomy

Use only `type/weekly` as the type tag. Do not add domain tags to
weekly summaries.
