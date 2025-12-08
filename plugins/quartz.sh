#!/usr/bin/env bash
set -euo pipefail

QUARTZ_DIR="$HOME/.quartz"
GARDEN_DIR="$HOME/garden"

# Clone garden repo if not present
if [[ ! -d "$GARDEN_DIR" ]]; then
    echo "🌱 Garden not found at $GARDEN_DIR"
    read -p "Enter your garden repository URL (or press Enter to skip): " GARDEN_REPO
    if [[ -n "$GARDEN_REPO" ]]; then
        git clone "$GARDEN_REPO" "$GARDEN_DIR"
    else
        echo "⏭️  Skipping garden clone. Create $GARDEN_DIR manually later."
        mkdir -p "$GARDEN_DIR"
    fi
fi

# Clone Quartz if not present
if [[ ! -d "$QUARTZ_DIR" ]]; then
    echo "📥 Cloning Quartz..."
    git clone --depth 1 https://github.com/jackyzha0/quartz.git "$QUARTZ_DIR"
    rm -rf "$QUARTZ_DIR/.git"
fi

# Install dependencies
if [[ ! -d "$QUARTZ_DIR/node_modules" ]]; then
    echo "📦 Installing Quartz dependencies..."
    cd "$QUARTZ_DIR" && npm install
fi

# Symlink custom configs (idempotent)
if [[ -d "$PROFILE_DIR/quartz" ]]; then
    for f in "$PROFILE_DIR/quartz/"*.ts; do
        [[ -e "$f" ]] || continue
        target="$QUARTZ_DIR/$(basename "$f")"
        [[ -L "$target" && "$(readlink "$target")" == "$f" ]] && continue
        ln -sf "$f" "$QUARTZ_DIR/"
    done
    for f in "$PROFILE_DIR/quartz/"*.scss; do
        [[ -e "$f" ]] || continue
        target="$QUARTZ_DIR/quartz/styles/$(basename "$f")"
        [[ -L "$target" && "$(readlink "$target")" == "$f" ]] && continue
        ln -sf "$f" "$QUARTZ_DIR/quartz/styles/"
    done
fi

# Symlink content to garden
if [[ ! -L "$QUARTZ_DIR/content" ]]; then
    rm -rf "$QUARTZ_DIR/content"
    ln -sfn "$GARDEN_DIR" "$QUARTZ_DIR/content"
fi

echo "✓ Quartz configured (content symlinked to $GARDEN_DIR)"
