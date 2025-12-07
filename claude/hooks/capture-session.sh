#!/usr/bin/env bash
# Capture Claude Code session data for journal generation
# Triggered by SessionEnd hook

set -euo pipefail

DRAFTS_DIR="$HOME/.claude/journal/drafts"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M%S)
DRAFT_FILE="$DRAFTS_DIR/${DATE}_${TIME}.md"

mkdir -p "$DRAFTS_DIR"

# Read session transcript from stdin (passed by hook)
TRANSCRIPT=$(cat)

# Only save if there is content
if [[ -n "$TRANSCRIPT" ]]; then
    cat > "$DRAFT_FILE" << EOF
---
captured: $(date -Iseconds)
project: ${PWD##*/}
status: draft
---

# Session Capture - $DATE

## Working Directory
\`$PWD\`

## Session Content

$TRANSCRIPT
EOF
    echo "Captured session to $DRAFT_FILE" >&2
fi
