#!/usr/bin/env bash
set -euo pipefail

# Installation check
if ! command -v claude &> /dev/null; then
    echo "📥 Claude not installed. Install via: https://claude.com/download"
    exit 0
fi

# Backup specific items (not entire .claude dir)
mkdir -p "$BACKUP_DIR/claude"
for item in commands skills agents prompts hooks settings.json CLAUDE.md; do
    if [[ -e "$HOME/.claude/$item" ]] && [[ ! -L "$HOME/.claude/$item" ]] && [[ ! -e "$BACKUP_DIR/claude/$item" ]]; then
        echo "📦 Backing up Claude $item"
        mv "$HOME/.claude/$item" "$BACKUP_DIR/claude/$item"
    fi
done

# Symlink individual items
mkdir -p "$HOME/.claude"
for item in commands skills agents prompts hooks settings.json CLAUDE.md; do
    if [[ -e "$PROFILE_DIR/claude/$item" ]]; then
        ln -sfn "$PROFILE_DIR/claude/$item" "$HOME/.claude/$item"
    fi
done

echo "✓ Claude configured"
