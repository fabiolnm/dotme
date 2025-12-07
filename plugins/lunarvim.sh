#!/usr/bin/env bash
set -euo pipefail

# Installation check
if ! command -v lvim &> /dev/null; then
    echo "📥 LunarVim not installed. Install via: https://www.lunarvim.org/docs/installation"
    exit 0
fi

# Backup lvim config
if [[ -d "$HOME/.config/lvim" ]] && [[ ! -L "$HOME/.config/lvim" ]] && [[ ! -d "$BACKUP_DIR/config/lvim" ]]; then
    echo "📦 Backing up LunarVim config"
    mkdir -p "$BACKUP_DIR/config"
    mv "$HOME/.config/lvim" "$BACKUP_DIR/config/lvim"
fi

# Symlink lvim directory
mkdir -p "$HOME/.config"
ln -sfn "$PROFILE_DIR/config/lvim" "$HOME/.config/lvim"

echo "✓ LunarVim configured"
