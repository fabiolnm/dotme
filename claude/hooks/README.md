# Claude Code Hooks

## What Are Hooks?

Hooks are shell commands that execute automatically in response to Claude Code events. They enable custom automation, logging, validation, and integration with external tools.

## Creating Hooks

```bash
# In a Claude session, type:
/hooks

# Claude will guide you through configuring hooks
```

## Hook Configuration

Hooks are stored in `~/.claude/settings.json` (or `settings.local.json`).

## Simple Example: Log Every User Prompt

**Use case**: Keep an audit trail of all prompts sent to Claude.

```json
{
  "hooks": {
    "user-prompt-submit": "echo \"$(date '+%Y-%m-%d %H:%M:%S') - $PROMPT\" >> ~/claude.log"
  }
}
```

**What happens**:
- Every time you submit a prompt
- The hook runs: appends timestamp + prompt to `~/claude.log`
- Non-intrusive: doesn't block or interfere with Claude

**View the log**:
```bash
tail -f ~/claude.log
```

## Available Hook Events

### user-prompt-submit
Triggered when user submits a prompt.

**Variables**:
- `$PROMPT`: The user's message

**Example uses**:
- Logging
- Backup prompts to external system
- Trigger notifications

### tool-call
Triggered before Claude executes a tool.

**Variables**:
- `$TOOL_NAME`: Name of the tool being called
- `$TOOL_ARGS`: Arguments passed to the tool

**Example**: Prevent dangerous operations
```json
{
  "hooks": {
    "tool-call": "if [[ \"$TOOL_NAME\" == \"Bash\" ]] && [[ \"$TOOL_ARGS\" == *\"rm -rf\"* ]]; then echo 'Blocked dangerous command' && exit 1; fi"
  }
}
```

### session-start
Triggered when Claude Code session starts.

**Example**: Show git status
```json
{
  "hooks": {
    "session-start": "git status --short"
  }
}
```

### session-end
Triggered when Claude Code session ends.

**Example**: Cleanup temp files
```json
{
  "hooks": {
    "session-end": "rm -f /tmp/claude-temp-*"
  }
}
```

## Hook Patterns

### Pattern 1: Conditional Logging
Log only specific types of prompts:

```bash
if [[ "$PROMPT" == *"security"* ]]; then
  echo "$(date) SECURITY: $PROMPT" >> ~/security-prompts.log
fi
```

### Pattern 2: External Integration
Send prompts to external system:

```bash
curl -X POST https://api.example.com/claude-activity \
  -H "Content-Type: application/json" \
  -d "{\"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\", \"prompt\": \"$PROMPT\"}"
```

### Pattern 3: Validation
Block prompts with sensitive data:

```bash
if [[ "$PROMPT" =~ (password|api[_-]?key|secret) ]]; then
  echo "⚠️  Detected sensitive data in prompt. Aborting."
  exit 1
fi
```

### Pattern 4: Metrics
Track prompt counts:

```bash
echo 1 >> ~/.claude/prompt-count.txt
COUNT=$(wc -l < ~/.claude/prompt-count.txt)
echo "Total prompts: $COUNT"
```

## Hook Configuration File

Edit `~/.claude/settings.json`:

```json
{
  "hooks": {
    "user-prompt-submit": "~/.claude/hooks/log-prompt.sh",
    "session-start": "echo '🤖 Claude session started'",
    "session-end": "~/.claude/hooks/cleanup.sh"
  }
}
```

## Creating Hook Scripts

For complex logic, use separate scripts:

**File**: `~/.claude/hooks/log-prompt.sh`
```bash
#!/usr/bin/env bash

# Log with context
LOGFILE=~/claude-prompts.log
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
PROJECT=$(basename "$PWD")

echo "[$TIMESTAMP] [$PROJECT] $PROMPT" >> "$LOGFILE"

# Rotate log if too large
if [[ $(stat -f%z "$LOGFILE" 2>/dev/null || stat -c%s "$LOGFILE") -gt 10485760 ]]; then
  mv "$LOGFILE" "${LOGFILE}.old"
fi
```

Make it executable:
```bash
chmod +x ~/.claude/hooks/log-prompt.sh
```

## Debugging Hooks

### Test hooks manually
```bash
export PROMPT="test prompt"
bash -c "$(jq -r '.hooks["user-prompt-submit"]' ~/.claude/settings.json)"
```

### Check hook errors
Hook failures are logged to Claude's debug output:
```bash
tail -f ~/.claude/debug/*.log
```

### Verbose hook output
Set `CLAUDE_HOOKS_DEBUG=1` before starting Claude:
```bash
export CLAUDE_HOOKS_DEBUG=1
claude
```

## Important Notes

⚠️ **Security**:
- Hooks run with your shell permissions
- Be careful with commands that modify files
- Validate input before using in hooks

⚠️ **Performance**:
- Keep hooks fast (< 100ms)
- Use background processes for slow operations
- Avoid blocking the main Claude workflow

⚠️ **Errors**:
- Hook failures (exit code ≠ 0) may block operations
- Test thoroughly before deploying
- Add error handling in hook scripts

## Hook Storage

Hooks configuration is in:
- **Local**: `~/.claude/settings.json` or `settings.local.json`
- **Not version controlled**: Hooks are machine-specific

Hook scripts can be in:
- **Repo**: `~/.me/claude/hooks/` (version controlled)
- **Symlink**: `~/.claude/hooks/` → `~/.me/claude/hooks/`

## Examples Gallery

### Git commit reminder
```json
{
  "hooks": {
    "session-end": "git status --short | grep -q '^ M' && echo '⚠️  You have uncommitted changes'"
  }
}
```

### Daily standup log
```json
{
  "hooks": {
    "user-prompt-submit": "if [[ \"$PROMPT\" == *\"done today\"* ]]; then echo \"$(date '+%Y-%m-%d'): $PROMPT\" >> ~/standup.log; fi"
  }
}
```

### Project context switch
```json
{
  "hooks": {
    "session-start": "echo \"Working on: $(basename $PWD)\" && git branch --show-current"
  }
}
```

## Disabling Hooks

Temporarily disable all hooks:
```bash
export CLAUDE_HOOKS_DISABLED=1
claude
```

Or remove from `settings.json`:
```json
{
  "hooks": {}
}
```
