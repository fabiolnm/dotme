#!/usr/bin/env bash
set -euo pipefail

# Installation check
if [ ! -d "/Applications/iTerm.app" ]; then
    echo "📥 iTerm not installed. Install via: brew install --cask iterm2"
    exit 0
fi

# Backup iTerm config
if [[ -d "$HOME/.iterm" ]] && [[ ! -L "$HOME/.iterm" ]] && [[ ! -d "$BACKUP_DIR/iterm" ]]; then
    echo "📦 Backing up iTerm config"
    mkdir -p "$BACKUP_DIR"
    mv "$HOME/.iterm" "$BACKUP_DIR/iterm"
fi

# Symlink iTerm directory
ln -sfn "$PROFILE_DIR/iterm" "$HOME/.iterm"

echo "✓ iTerm configured"
