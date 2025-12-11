# Journal Writer Skill

Transform Claude Code session captures into polished developer journal entries.

## Voice and Style

- **First person**: "I learned...", "I discovered...", "I built..."
- **Conversational but technical**: Explain concepts clearly without dumbing down
- **Honest about struggles**: Include what was confusing, what failed first
- **Practical focus**: Emphasize what works and why

## Entry Structure

Use this frontmatter:

```yaml
---
title: "LinkedIn-Attractive Title"
date: YYYY-MM-DD
tags:
  - relevant-tag
  - another-tag
draft: false
---
```

### Title Guidelines

Titles should be LinkedIn-attractive: professional yet engaging, with a hint of personality. They should promise value without being clickbait.

**Good patterns:**
- Outcome-focused: "Stacked PRs changed how I ship code"
- Bold claims: "The right way to authenticate with AWS"
- Concrete value: "From Docker build to AWS in 5 commands"
- Playful but professional: "Putting Claude Code minions to work"
- Problem-solution: "One command to launch my entire dev environment"

**Avoid:**
- Generic how-to: "How to use Git worktrees"
- Dry descriptions: "AWS IAM Identity Center setup"
- Clickbait: "You won't believe this Git trick"
- Jargon soup: "Implementing CI/CD pipeline optimization"
- Title Case: "A Single Repo For All My Developer Config" (use sentence case instead)

### Intro Paragraph

The intro must align with and deliver on the title's promise. Keep it to 2-3 sentences that:
- Reinforce the title's hook
- Set up the problem or transformation
- Give readers a reason to continue

**Example:** For "How I Built a Blog That Writes Itself":
> My blog writes itself. Every Claude Code session gets captured automatically. When I'm ready, a command synthesizes those captures into polished journal entries. I just review and publish.

### Content Structure

1. Intro paragraph (aligned with title)
2. ## The Problem - what was I trying to solve?
3. ## What I Learned - technical content with code
4. ## Key Takeaways - bullet points of main insights
5. See also: wikilinks to related topics

## Wikilink Guidelines

Add wikilinks to connect entries:

- **Languages**: Python, TypeScript, Bash
- **Tools**: Claude Code, Git, GitHub Actions
- **Concepts**: Decorators, Async/Await, CI/CD
- **Patterns**: Error Handling, Testing, Refactoring

## Tag Conventions

Use lowercase, hyphenated tags:
- python, typescript, bash
- debugging, refactoring, testing
- til (Today I Learned - for short entries)
- deep-dive (for longer explorations)

## Content Guidelines

1. **Extract the insight**: What is the one thing worth remembering?
2. **Show do not tell**: Include actual code that worked
3. **Link liberally**: Every technical term could be a wikilink
4. **Keep it scannable**: Headers, bullets, code blocks
5. **End with connections**: Related topics help build the graph
