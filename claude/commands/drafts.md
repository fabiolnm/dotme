# List Pending Drafts

Show all captured session drafts waiting to be turned into journal entries.

## Instructions

1. List files in `~/.claude/journal/drafts/`
2. Show date, project, and preview of each draft
3. Indicate which have not yet been processed

## Output Format

For each draft, show:
- Filename (contains date and time)
- Project name (from frontmatter)
- First 100 characters of content
- Status: pending or processed

## Actions

After reviewing drafts:
- Run `/journal` to generate an entry from today's drafts
- Manually delete old drafts after processing
