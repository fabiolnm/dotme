# Claude Code Memory Muscle

## Quick Reference

- **Shift+Tab**: Cycle between edit mode and plan mode
- **?**: Show Claude help

## When and How to Use

### Commands
Reusable prompts for repeated tasks.
- **When**: You find yourself typing the same instructions repeatedly
- **How**: Create `.claude/commands/name.md` with the prompt text
- **Example**: Code review checklist, test generation template

### Memories
Context Claude remembers across sessions.
- **When**: You want Claude to remember project-specific info
- **How**: Tell Claude "remember that..." - stored automatically
- **Example**: Architecture decisions, coding standards, team preferences

### Prompts
One-off prompt templates.
- **When**: Occasional complex instructions you want to reuse
- **How**: Store in `.claude/prompts/name.md`
- **Example**: PR description template, bug report format

### Skills
Multi-step workflows with tools and logic.
- **When**: Complex tasks requiring multiple operations
- **How**: Create `skill-name/SKILL.md` with frontmatter and logic
- **Example**: PDF processing, spreadsheet analysis, specialized workflows

### Personas
Agents with specific expertise and behavior.
- **When**: Need domain-specific guidance or review
- **How**: Create `.claude/agents/name.md` with role and instructions
- **Example**: Security auditor, Python coach, code reviewer

### Subagents
Task-specific specialized agents for complex operations.
- **When**: Need focused analysis or multi-step investigation
- **How**: Claude launches automatically via Task tool
- **Example**: Explore (codebase navigation), Plan (task breakdown)

### Zen MCP
Advanced AI tools via MCP server.
- **When**: Need deep analysis, consensus, or specialized workflows
- **How**: Claude uses mcp__zen__ tools automatically
- **Tools**: chat, thinkdeep, consensus, debug, codereview, analyze, refactor
- **Example**: Multi-model consensus, systematic debugging, code analysis
