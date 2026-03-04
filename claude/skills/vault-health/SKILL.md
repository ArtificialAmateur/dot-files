---
name: vault-health
description: Use when the user invokes /vault-health to run a structural audit of the Obsidian vault, finding orphans, stale MOCs, missing links, and knowledge clusters
user_invocable: true
---

# Vault Health

Run a structural audit of the Obsidian vault. Identify connectivity
gaps, stale indexes, and opportunities to link related knowledge.

## Workflow

### Step 1: Build vault graph

Read all markdown files in `~/Documents/work_logs/` (excluding
`.obsidian/` and `templates/`). For each file, collect:
- File path and type (from frontmatter tags)
- All outgoing `[[wiki links]]`
- All Dataview inline fields
- All tags

Build an in-memory map of: file → outgoing links, file → incoming
links (backlinks), file → tags.

### Step 2: Run checks

Perform each check below. Collect findings into categories.

**Orphan detection:**
Find notes in `notes/` with zero inbound backlinks — nothing in the
vault links to them. Exclude dashboards (they're entry points, not
link targets). Report each orphan with its type and tags.

**Cluster detection:**
Find groups of daily log sections or notes that share tags or wiki
link targets but are not connected by a topic note or MOC entry. For
example, if 5 daily logs all reference `[[Binder]]` but no topic note
about binder links back to them, that's a cluster that needs a topic
note or MOC entry.

**Stale MOCs:**
For each MOC in `notes/MOCs/`, check if there are notes in `notes/`
that clearly belong in the MOC's domain (by tag or content) but are
not listed. Report missing entries.

**Missing backlinks:**
Find pairs of notes that reference the same project or topic but don't
link to each other. For example, two topic notes both tagged
`kernel/binder` that don't cross-reference.

**Dead links:**
Find `[[wiki links]]` that point to notes that don't exist anywhere
in the vault. Report the source file and the broken link target.

**Tag inconsistencies:**
Find notes using tags not in the taxonomy defined in CLAUDE.md. Find
notes whose content suggests they should have domain tags but don't.

**Empty/stub notes:**
Find notes in `notes/` that have frontmatter but minimal or no body
content (less than 50 characters of non-frontmatter content).

**Unreviewed backlog:**
Count daily log sections without `[reviewed:: ...]` fields, broken
down by month. Report the total and trend.

### Step 3: Propose actions

For each finding, propose a specific action:

- "Create `notes/[Title].md` to connect these N related notes"
- "Add `[[Note Name]]` to `MOC - [Name].md` under [Section]"
- "Add backlink `[[Note A]]` to `notes/Note B.md`"
- "Add tag `kernel/binder` to `notes/Binder Offsets.md`"
- "Dead link `[[Nonexistent]]` found in `notes/X.md` — create note
  or remove link?"
- "`notes/Y.md` is a stub with no content — populate or delete?"

Present all findings grouped by category. Do NOT make any changes
until the user approves each action individually.

### Step 4: Execute approved actions

Write only the changes the user approves. After execution, present a
summary:
- Orphans resolved: N
- MOC entries added: N
- Backlinks added: N
- Tags fixed: N
- Dead links resolved: N
- Stubs addressed: N

## Output Format

Present findings as a structured report:

```
## Vault Health Report — YYYY-MM-DD

| Check | Findings |
|-------|----------|
| Orphaned notes | N |
| Clusters without topic notes | N |
| Stale MOC entries | N |
| Missing backlinks | N |
| Dead links | N |
| Tag inconsistencies | N |
| Empty stubs | N |
| Unreviewed sections | N (M months backlog) |

### Details
[Grouped findings with proposed actions]
```
