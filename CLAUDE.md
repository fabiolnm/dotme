# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

dotme (`.me`) is a plugin-based dotfiles manager for version-controlling development environment configurations. It manages symlinks between `~/.me/` and target locations (`~/.claude/`, `~/.config/lvim/`, etc.).

## Architecture

**Plugin System**: Self-contained bash scripts in `plugins/` that:
1. Check if tool is installed (warn, don't fail)
2. Backup existing configs to `~/.me.bkp/` (one-time, idempotent)
3. Create symlinks from home directory to profile directory

**Key Scripts**:
- `itsame` - Profile orchestrator. Discovers and runs all plugins. Handles profile switching.
- `rollback` - Restores original configs from `~/.me.bkp/`
- `splash.sh` - ASCII art display on activation

**Environment Variables** (set by itsame, used by plugins):
- `PROFILE_DIR` - Active profile directory (e.g., `~/.me` or `~/.me.mario`)
- `BACKUP_DIR` - Always `~/.me.bkp`

## Commands

```bash
./itsame                              # Activate current profile
./itsame <name>                       # Switch to ~/.me.<name>
./itsame <name> <git-url>            # Clone and switch to profile
./rollback                            # Restore from backup
```

## Adding a Plugin

Create `plugins/<tool>.sh`:
```bash
#!/usr/bin/env bash
set -euo pipefail

# 1. Check installation
if ! command -v TOOL &> /dev/null; then
    echo "📥 TOOL not installed. Install via: <command>"
    exit 0
fi

# 2. Backup (idempotent)
if [[ -e "$HOME/.config/TOOL" ]] && [[ ! -L "$HOME/.config/TOOL" ]] && [[ ! -e "$BACKUP_DIR/config/TOOL" ]]; then
    mkdir -p "$BACKUP_DIR/config"
    mv "$HOME/.config/TOOL" "$BACKUP_DIR/config/TOOL"
fi

# 3. Symlink
ln -sf "$PROFILE_DIR/config/TOOL" "$HOME/.config/TOOL"
echo "✓ TOOL configured"
```

## Directory Layout

```
~/.me/
├── plugins/           # Tool-specific scripts (auto-discovered)
├── claude/            # → ~/.claude/{agents,commands,skills,prompts,hooks}
├── config/lvim/       # → ~/.config/lvim
├── iterm/             # → ~/.iterm
├── itsame             # Orchestrator
└── rollback           # Restore script
```

## What Gets Symlinked vs Ignored

**Symlinked** (version controlled):
- `claude/{agents,commands,skills,prompts,hooks,CLAUDE.md}`
- `config/lvim/`
- `iterm/`

**Not Symlinked** (runtime/private):
- `~/.claude/{history.jsonl,memory/,debug/,settings/,sessions/}`
- `~/.claude/CLAUDE.md` when kept private (not in ~/.me/claude/)
