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
title: "Descriptive Title About What Was Learned"
date: YYYY-MM-DD
tags:
  - relevant-tag
  - another-tag
draft: false
---
```

Then structure content as:
1. Brief intro paragraph
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
