# .me - Personal Development Environment Management

## The Problem

### 1.1 dotme as Developer Avatar

Luigi and Mario both use dotme as their Personal Development Environment - their developer's avatars.

**Daily workflow:**
- Create new Claude commands and skills → commit to dotme
- Adjust IDE settings (iTerm, LunarVim, VSCode, Cursor, zsh, fish, etc.) → commit to dotme
- dotme = version-controlled representation of their development identity

### 1.2 Experimentation Challenge

**Scenario:** Luigi wants to try Mario's opinionated setup

**Current problem:**
- Luigi needs to install Mario's tools (zsh, Cursor, etc.)
- Luigi needs to configure Mario's preferences
- Lots of manual setup required
- Risk of breaking Luigi's current setup

## The Solution

### 2. Preferences Management (symlinks)

dotme configures each tool's preferences via symlinks.

**Profile structure:**
- `.me.bkp/` - Original backup (pre-dotme state)
- `.me/` - Luigi's profile
- `.me.mario/` - Mario's profile

**How it works:**
- Each profile contains preferences for tools (Claude, LunarVim, iTerm, etc.)
- Symlinks point active config locations (e.g., `~/.claude/`) to profile directories
- Switching profiles = updating symlinks to point to different profile directory

### 2.1 Directory Structure Conventions

Tools store preferences in two common locations:

**XDG Base Directory Standard** (`~/.config/`)
- Modern convention for application configs
- Examples: LunarVim, VSCode, Cursor
- Format: `~/.config/AppName/`
- Benefits: Centralized config location, easier to backup

**Traditional Dotfiles** (`~/.toolname/`)
- Legacy convention (predates XDG)
- Examples: Claude, iTerm
- Format: `~/.toolname/`

**dotme mirrors both conventions:**

```
~/.me/
├── config/              # XDG-compliant tools
│   ├── lvim/           → ~/.config/lvim/
│   └── cursor/         → ~/.config/Cursor/User/
├── claude/             # Traditional dotfiles
│   ├── commands/       → ~/.claude/commands
│   ├── skills/         → ~/.claude/skills
│   └── CLAUDE.md       → ~/.claude/CLAUDE.md
└── iterm/              → ~/.iterm/
```

**Why this matters:**
- dotme respects each tool's native config location
- Profile switching works regardless of convention
- Adding new tools: check where the tool stores configs, mirror in `.me/`

### 2.2 Architecture: Plugin System

**Components:**

**1. `plugins/TOOL.sh` = Self-Contained Tool Scripts**

Each tool has its own plugin script that handles everything for that tool:
- Installation verification
- Backup of existing configs
- Symlink creation

```bash
# plugins/zed.sh

# Installation check
if ! command -v zed &> /dev/null; then
    echo "📥 Zed not installed. Install via: brew install --cask zed"
    exit 0
fi

# Backup
if [[ -d "$HOME/.config/zed" && ! -L "$HOME/.config/zed" ]]; then
    echo "📦 Backing up Zed config"
    mkdir -p "$BACKUP_DIR/config"
    mv "$HOME/.config/zed" "$BACKUP_DIR/config/zed"
fi

# Symlink
mkdir -p "$HOME/.config"
ln -sf "$PROFILE_DIR/zed" "$HOME/.config/zed"
echo "✓ Zed configured"
```

**2. `./itsame` = Simple Orchestrator**

Discovers and runs all plugins:

```bash
for plugin in plugins/*.sh; do
    if [[ -f "$plugin" ]]; then
        bash "$plugin"
    fi
done
```

**Responsibility Matrix:**

| Concern | plugin.sh | itsame |
|---------|-----------|--------|
| Installation verification | ✅ | - |
| Backup configs | ✅ | - |
| Create symlinks | ✅ | - |
| Tool-specific logic | ✅ | - |
| Orchestrate | - | ✅ |
| Profile switching | - | ✅ |

**Benefits:**
- Modular - each tool isolated
- No hardcoding - adding tools creates new plugin
- Shareable - exchange plugins between users
- Testable - test each plugin independently
- Simple core - `./itsame` never changes
- Flexible - each tool installs however it needs

### 2.3 Plugin System Details

**Directory Structure:**

```
~/.me/
├── plugins/                 # Plugin scripts
│   ├── claude.sh
│   ├── cursor.sh
│   ├── zed.sh
│   ├── lunarvim.sh
│   └── iterm.sh
├── claude/                  # Claude preferences
│   ├── commands/
│   ├── skills/
│   └── CLAUDE.md
├── cursor/                  # Cursor preferences
│   ├── settings.json
│   └── keybindings.json
├── zed/                     # Zed preferences
│   └── settings.json
├── iterm/                   # iTerm preferences
│   └── .me.md
└── config/
    └── lvim/                # LunarVim preferences
```

**Plugin Template:**

Every `plugins/TOOL.sh` follows this pattern:

```bash
#!/usr/bin/env bash
set -euo pipefail

# 1. Installation check
if ! command -v TOOL &> /dev/null; then
    echo "📥 TOOL not installed. Install via: <installation-command>"
    exit 0
fi

# 2. Backup existing config (idempotent)
if [[ -e "$HOME/.config/TOOL" ]] && \
   [[ ! -L "$HOME/.config/TOOL" ]] && \
   [[ ! -e "$BACKUP_DIR/config/TOOL" ]]; then
    echo "📦 Backing up TOOL config"
    mkdir -p "$BACKUP_DIR/config"
    mv "$HOME/.config/TOOL" "$BACKUP_DIR/config/TOOL"
fi

# 3. Create symlinks (idempotent)
mkdir -p "$HOME/.config"
ln -sf "$PROFILE_DIR/TOOL" "$HOME/.config/TOOL"

# 4. Confirmation
echo "✓ TOOL configured"
```

**Example Plugins:**

**`plugins/claude.sh`:**
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
for item in commands skills agents prompts hooks CLAUDE.md .me.md; do
    if [[ -e "$HOME/.claude/$item" ]] && [[ ! -L "$HOME/.claude/$item" ]] && [[ ! -e "$BACKUP_DIR/claude/$item" ]]; then
        echo "📦 Backing up Claude $item"
        mv "$HOME/.claude/$item" "$BACKUP_DIR/claude/$item"
    fi
done

# Symlink individual items
mkdir -p "$HOME/.claude"
for item in commands skills agents prompts hooks CLAUDE.md .me.md; do
    if [[ -e "$PROFILE_DIR/claude/$item" ]]; then
        ln -sf "$PROFILE_DIR/claude/$item" "$HOME/.claude/$item"
    fi
done

echo "✓ Claude configured"
```

**`plugins/cursor.sh`:**
```bash
#!/usr/bin/env bash
set -euo pipefail

# Installation check
if [ ! -d "/Applications/Cursor.app" ]; then
    echo "📥 Cursor not installed. Install via: brew install --cask cursor"
    exit 0
fi

# Backup Cursor config
if [[ -d "$HOME/.config/Cursor" ]] && [[ ! -L "$HOME/.config/Cursor" ]] && [[ ! -d "$BACKUP_DIR/config/Cursor" ]]; then
    echo "📦 Backing up Cursor config"
    mkdir -p "$BACKUP_DIR/config"
    mv "$HOME/.config/Cursor" "$BACKUP_DIR/config/Cursor"
fi

# Symlink Cursor settings
mkdir -p "$HOME/.config/Cursor/User"
[[ -e "$PROFILE_DIR/cursor/settings.json" ]] && \
    ln -sf "$PROFILE_DIR/cursor/settings.json" "$HOME/.config/Cursor/User/settings.json"
[[ -e "$PROFILE_DIR/cursor/keybindings.json" ]] && \
    ln -sf "$PROFILE_DIR/cursor/keybindings.json" "$HOME/.config/Cursor/User/keybindings.json"

echo "✓ Cursor configured"
```

**`plugins/zed.sh`:**
```bash
#!/usr/bin/env bash
set -euo pipefail

# Installation check
if ! command -v zed &> /dev/null; then
    echo "📥 Zed not installed. Install via: brew install --cask zed"
    exit 0
fi

# Backup zed config
if [[ -d "$HOME/.config/zed" ]] && [[ ! -L "$HOME/.config/zed" ]] && [[ ! -d "$BACKUP_DIR/config/zed" ]]; then
    echo "📦 Backing up Zed config"
    mkdir -p "$BACKUP_DIR/config"
    mv "$HOME/.config/zed" "$BACKUP_DIR/config/zed"
fi

# Symlink zed directory
mkdir -p "$HOME/.config"
ln -sf "$PROFILE_DIR/zed" "$HOME/.config/zed"

echo "✓ Zed configured"
```

**`plugins/iterm.sh`:**
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

**Creating New Plugins:**

To add a new tool, simply create a plugin script following the template above. The script should:
1. Check if the tool is installed
2. Backup existing configs
3. Create symlinks to profile directory

## Complete Workflow

### 4.1 Initial Setup (Luigi's First Time)

```bash
# Clone Luigi's dotme
git clone https://github.com/luigi/dotme.git ~/.me
cd ~/.me

# Setup
./itsame
```

**What happens:**

1. **`./itsame` detects current profile**
   - Checks pwd: `~/.me` → profile is "main"
   - No args provided → activates current profile

2. **`./itsame` discovers and runs all plugins:**

   **`plugins/claude.sh` runs:**
   - Checks if Claude installed
   - Backs up specific Claude items (commands, skills, agents, prompts, hooks, CLAUDE.md, .me.md) → `~/.me.bkp/claude/`
   - Creates symlinks for each item: `~/.me/claude/commands` → `~/.claude/commands`, etc.
   - Output: `✓ Claude configured`

   **`plugins/lunarvim.sh` runs:**
   - Checks if LunarVim installed
   - Backs up `~/.config/lvim/` if exists → `~/.me.bkp/config/lvim/`
   - Creates symlink: `~/.me/config/lvim` → `~/.config/lvim`
   - Output: `✓ LunarVim configured`

   **`plugins/fish.sh` runs:**
   - Checks if fish installed
   - Backs up `~/.config/fish/` if exists → `~/.me.bkp/config/fish/`
   - Creates symlink: `~/.me/config/fish` → `~/.config/fish`
   - Output: `✓ fish configured`

**Result:** Luigi's preferences synced via dotme.

### 4.2 Adding a New Tool

**Scenario:** Luigi wants to add Zed IDE to his setup

**Step 1: Install Zed**

```bash
brew install --cask zed
```

**Step 2: Create plugin script**

```bash
cd ~/.me
cat > plugins/zed.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

# Installation check
if ! command -v zed &> /dev/null; then
    echo "📥 Zed not installed. Install via: brew install --cask zed"
    exit 0
fi

# Backup existing zed config
if [[ -d "$HOME/.config/zed" ]] && [[ ! -L "$HOME/.config/zed" ]] && [[ ! -d "$BACKUP_DIR/config/zed" ]]; then
    echo "📦 Backing up Zed config"
    mkdir -p "$BACKUP_DIR/config"
    mv "$HOME/.config/zed" "$BACKUP_DIR/config/zed"
fi

# Symlink zed directory
mkdir -p "$HOME/.config"
ln -sf "$PROFILE_DIR/zed" "$HOME/.config/zed"
echo "✓ Zed configured"
EOF

chmod +x plugins/zed.sh
```

**Step 3: Run `./itsame` to activate**

```bash
./itsame
```

```
✓ claude configured
✓ lunarvim configured
✓ fish configured
📦 Backing up Zed config
✓ Zed configured

✓ Profile 'main' activated
```

Now `~/.config/zed` → `~/.me/zed` symlink is active. When Luigi configures Zed through its UI, settings will automatically be saved to `~/.me/zed/` and tracked by git.

**Step 4: Commit changes**

```bash
git add plugins/zed.sh
git commit -m "Added Zed plugin"
```

Later, after configuring Zed:

```bash
git add zed/
git commit -m "Configured Zed preferences"
```

**Result:** Zed is now part of Luigi's dotme setup.

### 4.3 Idempotency

**Running `./itsame` multiple times:**

```bash
cd ~/.me
./itsame  # Run again
```

**Behavior:**

Each plugin runs again and handles idempotency:

**Installation check in each plugin:**
- Tool not installed? → Show message, skip configuration
- Tool installed? → Continue to backup/symlink

**Backup logic in each plugin:**
- Already a symlink? → Skip backup (already managed)
- Already backed up? → Skip backup (preserve original)
- Real files exist? → Back up now
- Nothing exists? → Nothing to backup

**Symlink creation in each plugin:**
- `ln -sf` is idempotent (force overwrites)
- Symlink correct? → No-op
- Symlink broken? → Fixed
- Missing? → Created

**Key guarantees:**
- Each tool's backup in `.me.bkp/` is done once (never overwritten)
- Safe to run after crashes, git pulls, or manual changes
- Each plugin handles its own idempotency
- Repairs broken state automatically

**Use cases:**
- After system crash → repairs symlinks
- After git pull with new plugins → configures new tools
- After manual config deletion → recreates symlinks
- Verification → confirms everything correct

**Example output:**
```
$ ./itsame
Activating profile: main

✓ claude configured
✓ lunarvim configured
✓ fish configured

✓ Profile 'main' activated
```

### 4.4 Trying Mario's Setup

**Scenario:** Luigi wants to experiment with Mario's setup

```bash
cd ~/.me
./itsame mario https://github.com/mario/dotme.git
```

**What happens:**

1. **`./itsame` clones Mario's profile** (if not already cloned)
   ```bash
   git clone https://github.com/mario/dotme.git ~/.me.mario
   ```

2. **`./itsame` switches to Mario's profile**
   ```bash
   cd ~/.me.mario
   ./itsame  # Activates mario profile
   ```

3. **Runs Mario's plugins:**

   **`plugins/claude.sh` runs:**
   - Checks if Claude installed
   - Specific items already symlinked? → Skips backup
   - Updates symlinks for each item: `~/.me.mario/claude/commands` → `~/.claude/commands`, etc.
   - Output: `✓ Claude configured`

   **`plugins/cursor.sh` runs:**
   - Checks if Cursor installed
   - `~/.config/Cursor/` doesn't exist yet (Luigi doesn't use Cursor)
   - Creates symlinks: `~/.me.mario/cursor/*` → `~/.config/Cursor/User/*`
   - Output: `✓ Cursor configured`

   **`plugins/zsh.sh` runs:**
   - Checks if zsh installed
   - `~/.zshrc` doesn't exist (Luigi uses fish)
   - Creates symlink: `~/.me.mario/zsh/.zshrc` → `~/.zshrc`
   - Output: `✓ zsh configured`

4. **Complete:**
   - Luigi's system now reflects Mario's setup
   - All configs point to `~/.me.mario/`
   - Luigi's original setup preserved in `~/.me/` and `~/.me.bkp/`

### 4.5 Switching Back

```bash
cd ~/.me.mario  # or wherever you are
./itsame main   # Switch back to main profile
```

**What happens:**

1. **`./itsame` switches to main profile**
   ```bash
   cd ~/.me
   ./itsame  # Activates main profile
   ```

2. **`./itsame` runs Luigi's plugins:**

   **`plugins/claude.sh` runs:**
   - Updates symlinks: `~/.me/claude/*` → `~/.claude/*` (back to Luigi's)
   - Output: `✓ Claude configured`

   **`plugins/lunarvim.sh` runs:**
   - Updates symlink: `~/.me/config/lvim` → `~/.config/lvim`
   - Output: `✓ LunarVim configured`

   **`plugins/fish.sh` runs:**
   - Updates symlink: `~/.me/config/fish` → `~/.config/fish`
   - Output: `✓ fish configured`

**Result:** Luigi's setup restored.

### 4.6 Rollback to Original

```bash
./rollback
```

**What happens:**
1. Removes all symlinks
2. Restores files from `~/.me.bkp/`
3. System back to pre-dotme state

## Key Design Principles

### Idempotency
- Safe to run `./itsame` multiple times
- Repairs broken state without data loss
- Warns instead of fails

### Backup Safety
- `.me.bkp/` created once, never overwritten
- Always preserves original pre-dotme state
- Each new tool backs up on first setup

### Profile Independence
- `.me/` = Luigi's profile
- `.me.mario/` = Mario's profile
- `.me.bkp/` = Original backup
- Switching = updating symlinks, not moving files

### Plugin Simplicity
- Each plugin self-contained
- Installation documented per tool
- No external dependencies

### Fail Resilience
- Broken symlinks → recreated
- Missing tools → skip with message
- Corrupted state → repaired
- Logs warnings, doesn't break

## Implementation Reference

### Complete `./itsame` Script

```bash
#!/usr/bin/env bash
set -euo pipefail

# Detect current profile from directory name
detect_profile() {
    local repo_name=$(basename "$(pwd)")

    if [[ "$repo_name" == ".me" ]]; then
        echo "main"
    elif [[ "$repo_name" =~ ^\.me\. ]]; then
        echo "$repo_name" | sed 's/^\.me\.//'
    else
        echo "unknown"
    fi
}

# Main activation logic
activate_profile() {
    local profile=$(detect_profile)

    # Export environment for plugins
    export BACKUP_DIR="$HOME/.me.bkp"
    export PROFILE_DIR="$(pwd)"

    # Run all plugins
    for plugin in plugins/*.sh; do
        if [[ -f "$plugin" ]]; then
            bash "$plugin"
        fi
    done

    echo ""
    echo "✓ Profile '$profile' activated"
}

# ========== MAIN LOGIC ==========

# No args = activate current profile
if [[ -z "${1:-}" ]]; then
    current=$(detect_profile)

    if [[ "$current" == "unknown" ]]; then
        echo "Error: Not in a dotme profile directory"
        echo "Expected directory name: .me or .me.<profile>"
        exit 1
    fi

    echo "Activating profile: $current"
    echo ""
    activate_profile
    exit 0
fi

# Args = switch to different profile
profile="$1"
repo_url="${2:-}"

# Clone if URL provided
if [[ -n "$repo_url" ]]; then
    profile_dir="$HOME/.me.$profile"

    if [[ ! -d "$profile_dir" ]]; then
        echo "Cloning $repo_url to $profile_dir..."
        git clone "$repo_url" "$profile_dir"
    else
        echo "Profile '$profile' already exists at $profile_dir"
    fi
else
    # No URL, profile must exist
    profile_dir="$HOME/.me"
    [[ "$profile" != "main" ]] && profile_dir="$HOME/.me.$profile"

    if [[ ! -d "$profile_dir" ]]; then
        echo "Error: Profile '$profile' not found at $profile_dir"
        echo "Usage: ./itsame <profile> [repo-url]"
        exit 1
    fi
fi

# Switch to profile directory and activate
echo "Switching to profile: $profile"
cd "$profile_dir" && ./itsame
```

**Key features:**
- **Simple orchestrator** - Discovers and runs all plugins
- **No hardcoded tools** - All tool logic in `plugins/TOOL.sh`
- **Profile detection** - Based on directory name (pwd)
- **Profile switching** - Clone + activate with one command
- **~50 lines** - minimal and maintainable
