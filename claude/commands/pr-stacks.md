# PR Stacks Overview

Show Graphite PR stacks with branch names and status.

## Usage

- `/pr-stacks` - Show all PRs with branch names
- `/pr-stacks merged` - Show only merged PRs
- `/pr-stacks clean` - Remove worktrees for merged PRs, then sync Graphite

## Output Format

```
◯ feature/branch-name
│ PR #XX (Status) PR title

◯ feature/another-branch
│ PR #YY (Status) PR title
```

## Instructions

1. Run `git fetch --prune` to update remote state
2. Run the appropriate gt log command based on argument

## Commands

**All PRs:**
```bash
git fetch --prune
gt log | grep -E "◯|│ PR #|│  │ PR #" | grep -v "https://" | sed '/PR #/G'
```

**Merged PRs only (argument: merged):**
```bash
git fetch --prune
gt log | grep -B3 Merged | grep -E "◯|PR.*Merged" | sed '/PR #/G'
```

**Clean merged worktrees (argument: clean):**

1. Check `git status` on develop - if not clean, STOP and tell developer to clean up first
2. Run `git fetch --prune`
3. Get list of merged branches from `gt log | grep -B3 Merged | grep "^◯" | sed 's/◯ //'`
4. For each merged branch, find its worktree path from `git worktree list`
5. Run `git worktree remove <path>` (never use --force)
6. If removal fails, STOP and tell the developer why (dirty worktree, uncommitted changes, etc.)
7. After all worktrees are removed, run `gt sync` and answer Y to delete branch prompts
