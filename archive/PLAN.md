# .me Rollback and Profile Switching - Implementation Plan

## Overview
Transform `.me` from a one-way setup into a flexible profile management system with rollback capability and multi-profile switching.

**Key Architectural Decision: Plugin-based system replaces setup.sh**

## Quick Start (New Workflow)

```bash
# Clone your .me profile
git clone github:fabiolnm/.me.git ~/.me

# Activate profile (creates symlinks + backups)
cd ~/.me
./itsame

# Done! Your environment is configured

# Try a friend's profile
git clone github:mario/dotme.git ~/.me.mario
./itsame mario              # Switches to Mario's setup

# Switch back
./itsame main               # Back to your setup

# Rollback to pre-.me state
./rollback                  # Restores original configs
```


## Current State
- `.me` repository exists but `setup.sh` has NOT been run yet
- Files in `~/.claude/`, `~/.config/lvim/`, etc. are still REAL directories (not symlinks)
- No backups exist yet
- No other `.me.*` profile directories exist

## Architecture Decisions

### 1. Backup Location Strategy (SIMPLIFIED)
- **`~/.me.bkp/`**: One-time snapshot of ORIGINAL pre-.me state (sibling to `.me/`)

### 2. Profile Naming Convention
Use `~/.me.<name>` pattern:
- `~/.me` - Main profile (user's personal setup)
- `~/.me.mario` - Friend's profile (cloned from their repo)
- `~/.me.bkp` - Original backup (pre-.me files)

### 3. Switching Strategy
- Validate target profile exists and has required structure
- Create new symlinks from target profile (`ln -sf` overwrites existing)
- On failure: run `./itsame` again or `./itsame other_profile` (idempotent)

### 4. Missing Files Handling
Best-effort approach:
- Warn if source missing in new profile
- Continue switching (don't fail)
- Log all mismatches for user review
- Provide `--verify` flag to check completeness before switching

### 5. Adding New Tools After Setup
**Use Case:** User has `.me` configured (Claude, LunarVim, iTerm) and wants to add Cursor/VSCode

**Workflow:**
1. Create plugin script in `plugins/cursor.sh`:
   ```bash
   cat > plugins/cursor.sh <<'EOF'
   #!/usr/bin/env bash
   set -euo pipefail

   if [ ! -d "/Applications/Cursor.app" ]; then
       echo "📥 Cursor not installed. Install via: brew install --cask cursor"
       exit 0
   fi

   if [[ -d "$HOME/.config/Cursor" ]] && [[ ! -L "$HOME/.config/Cursor" ]] && [[ ! -d "$BACKUP_DIR/config/Cursor" ]]; then
       echo "📦 Backing up Cursor config"
       mkdir -p "$BACKUP_DIR/config"
       mv "$HOME/.config/Cursor" "$BACKUP_DIR/config/Cursor"
   fi

   mkdir -p "$HOME/.config/Cursor/User"
   ln -sf "$PROFILE_DIR/cursor/settings.json" "$HOME/.config/Cursor/User/settings.json"
   echo "✓ Cursor configured"
   EOF
   chmod +x plugins/cursor.sh
   ```
2. Run `./itsame`:
   - Auto-creates `.me/cursor/` if missing
   - Detects new plugin automatically
   - Backs up existing `~/.config/Cursor` to `.me.bkp/config/Cursor/` (if exists and not already backed up)
   - Creates symlinks `~/.config/Cursor/User/* → ~/.me/cursor/*`
   - Preserves existing `.me.bkp/` content (doesn't overwrite)
3. Populate `.me/cursor/` with your preferences

**Key Behaviors:**
- `./itsame` is **idempotent** - safe to re-run
- Plugins auto-discovered from `plugins/` directory
- Existing `.me.bkp/` entries are preserved (one-time backup)
- New tool configs get backed up to `.me.bkp/` if they exist locally
- All profiles (`.me`, `.me.mario`) need to be updated independently

## Implementation Phases

### Phase 0: Plugin-Based Architecture

**Each plugin handles:**
- Installation check (warns if missing, doesn't fail)
- Backup existing configs (idempotent)
- Create symlinks (idempotent)

**Profile Structure:**

```
~/.me/
├── plugins/                  # Self-contained tool scripts
│   ├── claude.sh            # Manages Claude symlinks
│   ├── lunarvim.sh          # Manages LunarVim symlinks
│   ├── iterm.sh             # Manages iTerm symlinks
│   └── cursor.sh            # Manages Cursor symlinks
├── claude/                   # Claude preferences
├── config/lvim/              # LunarVim preferences
├── iterm/                    # iTerm preferences
└── itsame                    # Orchestrator (discovers/runs plugins)
```

**Plugin Template (plugins/TOOL.sh):**

Each plugin is self-contained and handles everything for that tool:

```bash
#!/usr/bin/env bash
set -euo pipefail

# 1. Installation check (warn only, don't fail)
if ! command -v TOOL &> /dev/null; then
    echo "📥 TOOL not installed. Install via: brew install --cask tool"
    exit 0  # Exit gracefully, not an error
fi

# 2. Backup existing config (idempotent - only backs up once)
if [[ -e "$HOME/.config/TOOL" ]] && \
   [[ ! -L "$HOME/.config/TOOL" ]] && \
   [[ ! -e "$BACKUP_DIR/config/TOOL" ]]; then
    echo "📦 Backing up TOOL config"
    mkdir -p "$BACKUP_DIR/config"
    mv "$HOME/.config/TOOL" "$BACKUP_DIR/config/TOOL"
fi

# 3. Create symlinks (idempotent - ln -sf overwrites)
mkdir -p "$HOME/.config"
ln -sf "$PROFILE_DIR/TOOL" "$HOME/.config/TOOL"

# 4. Confirmation
echo "✓ TOOL configured"
```

**./itsame Orchestrator (simple discovery):**

```bash
#!/usr/bin/env bash
set -euo pipefail

# Export environment for plugins
export BACKUP_DIR="$HOME/.me.bkp"
export PROFILE_DIR="$(pwd)"

# Discover and run all plugins
for plugin in plugins/*.sh; do
    if [[ -f "$plugin" ]]; then
        bash "$plugin"
    fi
done

echo ""
echo "✓ Profile activated"
```

### Phase 1: Create Plugin Structure

**1. Create `plugins/` directory:**
```bash
mkdir -p ~/.me/plugins
```

**2. Create `plugins/claude.sh`:**
```bash
#!/usr/bin/env bash
set -euo pipefail

# Installation check
if ! command -v claude &> /dev/null; then
    echo "📥 Claude not installed. Install via: https://claude.com/download"
    exit 0
fi

# Backup specific items (not entire .claude dir)
mkdir -p "$BACKUP_DIR/claude"
for item in commands skills agents prompts hooks CLAUDE.md; do
    if [[ -e "$HOME/.claude/$item" ]] && [[ ! -L "$HOME/.claude/$item" ]] && [[ ! -e "$BACKUP_DIR/claude/$item" ]]; then
        echo "📦 Backing up Claude $item"
        mv "$HOME/.claude/$item" "$BACKUP_DIR/claude/$item"
    fi
done

# Symlink individual items
mkdir -p "$HOME/.claude"
for item in commands skills agents prompts hooks CLAUDE.md; do
    if [[ -e "$PROFILE_DIR/claude/$item" ]]; then
        ln -sf "$PROFILE_DIR/claude/$item" "$HOME/.claude/$item"
    fi
done

echo "✓ Claude configured"
```

**3. Create `plugins/lunarvim.sh`:**
```bash
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
ln -sf "$PROFILE_DIR/config/lvim" "$HOME/.config/lvim"

echo "✓ LunarVim configured"
```

**4. Create `plugins/iterm.sh`:**
```bash
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
ln -sf "$PROFILE_DIR/iterm" "$HOME/.iterm"

echo "✓ iTerm configured"
```

### Phase 2: Create `rollback` Script

```bash
#!/usr/bin/env bash
# ~/.me/rollback

set -euo pipefail

BACKUP_DIR="$HOME/.me.bkp"

if [[ ! -d "$BACKUP_DIR" ]]; then
    echo "Error: Backup not found at $BACKUP_DIR"
    echo "Cannot rollback without backup"
    exit 1
fi

echo "This will restore your original configs from $BACKUP_DIR"
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted"
    exit 0
fi

# Remove symlinks
echo "Removing symlinks..."
rm -f ~/.claude/agents ~/.claude/commands ~/.claude/skills ~/.claude/prompts
rm -f ~/.claude/hooks ~/.claude/CLAUDE.md
rm -f ~/.config/lvim
rm -f ~/.iterm

# Restore original files
echo "Restoring original files..."
cp -R "$BACKUP_DIR"/* ~/

echo "✓ Rolled back to pre-.me state"
```

### Phase 3: Create `itsame` Profile Switcher

See EXPANDED-FEATURES.md section 2.2 for complete script (~50 lines).

**Usage:**
```bash
./itsame                          # Activate current profile
./itsame mario                    # Switch to mario profile
./itsame mario <repo-url>         # Clone and switch
```

### Phase 4: Update Documentation

**Update README.md with:**
- Plugin system architecture
- Profile switching workflow
- Adding new tools process
- Rollback instructions

## Implementation Checklist

### Files to Create
- [ ] `plugins/` directory - Contains self-contained tool scripts
- [ ] `plugins/claude.sh` - Claude symlink management
- [ ] `plugins/lunarvim.sh` - LunarVim symlink management
- [ ] `plugins/iterm.sh` - iTerm symlink management
- [ ] `itsame` - Plugin orchestrator and profile switcher
- [ ] `rollback` - Script to restore from .me.bkp

### Files to Delete
- [ ] `setup.sh` - **REMOVED** - replaced by plugin system

### Files to Modify
- [ ] `README.md` - Update with plugin-based workflow, remove setup.sh references
- [ ] `.gitignore` - Ensure plugins/ is tracked

### Testing Strategy
After implementation:

**Phase 1: Initial Setup**
1. [ ] Test fresh setup creates `.me.bkp` correctly
   - Run `./itsame` in new `.me/` directory
   - Verify backup created at `~/.me.bkp/`
   - Verify backup contains original files
2. [ ] Test plugins check for installed tools
   - Run plugin without tool installed
   - Verify warning displayed (not error)
   - Verify plugin exits gracefully
3. [ ] Test symlinks created correctly
   - Verify `~/.claude/agents` points to `~/.me/claude/agents`
   - Check all symlinks from all plugins
4. [ ] Test idempotency
   - Run `./itsame` twice
   - Verify backup not overwritten
   - Verify no errors on second run

**Phase 2: Profile Switching**
5. [ ] Test profile switching between different profiles
   - Create `~/.me.mario/` with different plugins
   - Run `./itsame mario`
   - Verify symlinks point to `~/.me.mario/`
   - Verify plugins warn if tools missing
6. [ ] Test switching back
   - Run `./itsame main`
   - Verify symlinks point to `~/.me/`
7. [ ] Test profile listing
   - Run `./itsame` with no args
   - Verify current profile shown
   - Verify all `.me.*` profiles listed

**Phase 3: Rollback**
8. [ ] Test rollback fully restores original state
   - Run `./rollback`
   - Verify symlinks removed
   - Verify original files restored from `.me.bkp/`

**Phase 4: Adding New Tools**
9. [ ] Test adding new tool after initial setup
    - Create `plugins/cursor.sh`
    - Create `cursor/` directory
    - Run `./itsame`
    - Verify plugin auto-discovered
    - Verify cursor symlinks created
10. [ ] Test profile without plugins/ (edge case)
    - Create profile without plugins directory
    - Run `./itsame badprofile`
    - Verify graceful handling

**Phase 5: Cross-Profile**
11. [ ] Test multiple profile switches in sequence
    - main → mario → main → bkp → main
    - Verify each switch completes successfully

## Safety Considerations

### Pre-Operation Checks
- Verify target profile exists
- Validate profile structure (has plugins/ directory)
- Check write permissions
- Confirm with user for destructive operations (rollback)
- Warn if plugins/ directory missing

### During Operation
- Detect current profile before making changes
- Log all operations for debugging
- Use atomic operations where possible
- Handle errors gracefully

### Post-Operation
- Verify symlinks created correctly
- Report any warnings or issues
- On failure: automatically recreate previous profile symlinks
- User can also manually switch back: `./itsme previous_profile`

## Future Extensions

### Potential Features
- `./addtool cursor ~/.cursor` - Helper script to automate:
  - Generate plugin template in `plugins/cursor.sh`
  - Create `.me/cursor/` directory
  - Run `./itsame` automatically
  - Show git status of changes
- `itsame --merge` - Merge configurations from multiple profiles
- `itsame --diff mario` - Show differences between profiles
- `itsame --export` - Export current config to new profile
- `itsame --import <url>` - Import profile from git URL
- Profile metadata (description, author, version) in `.me.yaml`
- Plugin dependency checking (e.g., requires LunarVim installed)
- Plugin marketplace/registry for sharing

### Profile Repository Structure
```
~/
├── .me/                          # Main profile (version controlled)
│   ├── plugins/                  # Self-contained tool scripts
│   │   ├── claude.sh
│   │   ├── lunarvim.sh
│   │   └── iterm.sh
│   ├── claude/                   # Claude preferences
│   ├── config/lvim/              # LunarVim preferences
│   ├── iterm/                    # iTerm preferences
│   ├── itsame                    # Plugin orchestrator
│   ├── rollback                  # Restore script
│   ├── .gitignore
│   └── README.md
│
├── .me.mario/                    # Friend's profile (cloned separately)
│   ├── plugins/                  # Mario's plugins
│   │   ├── claude.sh
│   │   ├── lunarvim.sh
│   │   └── zsh.sh
│   ├── claude/                   # Mario's Claude setup
│   ├── config/lvim/              # Mario's LunarVim config
│   ├── itsame
│   ├── rollback
│   └── README.md
│
└── .me.bkp/                      # Original backup (created by plugins)
    ├── claude/                   # Original ~/.claude/* items
    │   ├── agents/
    │   ├── commands/
    │   └── CLAUDE.md
    ├── config/
    │   └── lvim/                 # Original ~/.config/lvim (if existed)
    └── iterm/                    # Original ~/.iterm (if existed)
```

## Implementation Notes

### Symlink Mappings (from plugins)
```bash
# plugins/claude.sh creates:
claude/agents → ~/.claude/agents
claude/commands → ~/.claude/commands
claude/skills → ~/.claude/skills
claude/prompts → ~/.claude/prompts
claude/hooks → ~/.claude/hooks
claude/CLAUDE.md → ~/.claude/CLAUDE.md

# plugins/lunarvim.sh creates:
config/lvim → ~/.config/lvim

# plugins/iterm.sh creates:
iterm → ~/.iterm
```
