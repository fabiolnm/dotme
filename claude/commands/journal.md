# Generate Journal Entry

Generate a polished journal entry from today's session captures.

## Instructions

1. Read all draft files from `~/garden/drafts/` for today's date
2. Load the journal-writer skill from `~/.me/claude/skills/journal-writer/SKILL.md`
3. Synthesize the session captures into a single cohesive journal entry
4. Follow the voice, style, and structure from the skill
5. Add appropriate wikilinks to technical terms
6. Save to `~/garden/entries/` with format `YYYY-MM-DD-slug.md`
7. Set `draft: true` in frontmatter for review

## Output Location

Save the generated entry to: `~/garden/entries/YYYY-MM-DD-descriptive-slug.md`

The slug should be derived from the title (lowercase, hyphenated).

## After Generation

- Open in Obsidian to review
- Check graph connections
- Set `draft: false` when ready to publish
- Run `/publish` to deploy
