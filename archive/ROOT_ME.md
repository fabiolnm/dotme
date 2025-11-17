# Personal Development Environment

This repository contains my AI-assisted development workspace configuration.

## Purpose

Managing cognitive load when working with AI tools requires:
- Consistent tool preferences across sessions
- Quick context switching between terminal, editor, and AI
- Memory muscles for common workflows
- Version-controlled configuration evolution

## Structure

```
~/.me/
├── .claude/          # Claude Code agents, commands, skills, prompts
├── .config/lvim/     # LunarVim configuration
├── .iterm/           # iTerm2 workflow documentation
├── archive/          # Historical requirements and design docs
├── setup.sh          # Installation script (creates symlinks)
└── .me.md            # This file - global memory muscles
```

## Memory Muscle Philosophy

Each tool directory contains its own `.me.md` for domain-specific patterns:
- `.claude/.me.md` - Claude orchestration patterns
- `.config/lvim/.me.md` - Editor workflows and keybindings
- `.iterm/.me.md` - Terminal window management

This file captures **cross-cutting insights** that span multiple tools.

## Setup

```bash
cd ~/.me
./setup.sh
```

The setup script:
- Backs up existing configurations
- Creates symlinks from standard locations to this repo
- Is idempotent (safe to run multiple times)

## Workflow

### First Time Clone and Setup
```bash
git clone <your-repo-url> ~/.me
cd ~/.me
./setup.sh  # Zero manual steps - local files take precedence
git diff    # Review what changed from baseline
```

### Adding New Claude Agents/Commands
```bash
# Just create in ~/.claude/ (it's symlinked to ~/.me/)
cd ~/.claude/agents
# create new-agent.md

# Commit from ~/.me
cd ~/.me
git status
git add .claude/agents/new-agent.md
git commit -m "Add new agent"
```

### Customizing LunarVim
```bash
# Edit in normal location (it's symlinked)
cd ~/.config/lvim
# edit config.lua

# Commit from ~/.me
cd ~/.me
git add .config/lvim/config.lua
git commit -m "Customized lvim keybinding"
```

### Recording Workflow Insights
```bash
# Edit memory muscles where they live
cd ~/.claude  # or ~/.config/lvim or ~/.iterm
lvim .me.md

# Commit from ~/.me
cd ~/.me
git commit -am "Document new workflow pattern"
```

## Design Principles

See `archive/requirements.md` for the original problem statement and design rationale.

Key principles:
- **Safe isolation**: Only explicitly managed files are versioned
- **Idempotent operations**: Scripts can run repeatedly without harm
- **Backup first**: Never overwrite without preserving originals
- **Shareable baseline**: Others can fork and customize

## Global Memory Muscles

### Cross-Tool Patterns

*This section grows as you discover patterns that span multiple tools*

### Cognitive Load Reducers

*Document workflows that successfully reduce context switching*

### Integration Points

*How tools work together (e.g., Claude + LunarVim + iTerm)*
