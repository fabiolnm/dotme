#!/usr/bin/env bash
set -euo pipefail

# Install Obsidian if not present
if ! [[ -d "/Applications/Obsidian.app" ]]; then
    brew install --cask obsidian
fi

# Create journal drafts directory for Claude Code integration
mkdir -p "$HOME/.claude/journal/drafts"

echo "✓ Obsidian configured"
