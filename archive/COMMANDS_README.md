# Claude Code Commands

## What Are Commands?

Commands are reusable prompt templates stored as markdown files. They're shortcuts for instructions you type repeatedly, accessible with `/command-name`.

## When to Use Commands

- **Repeated instructions**: Same prompt used across multiple sessions
- **Consistent workflows**: Code reviews, test generation, documentation
- **Team standards**: Shared checklists and procedures
- **Quick access**: Complex prompts without retyping

## Creating Commands

### Quick Creation
Just create a markdown file in this directory:

```bash
cd ~/.claude/commands
vim my-command.md
```

### Command Structure

**File**: `code-review.md`
```markdown
Review this code for:
- Logic errors and edge cases
- Performance issues
- Security vulnerabilities
- Code style and readability
- Missing tests

Provide specific line numbers and suggestions.
```

**Usage**:
```bash
# In Claude session:
/code-review
```

## Simple Examples

### Example 1: Test Generator

**File**: `gen-tests.md`
```markdown
Generate unit tests for the current file using:
- pytest for Python
- jest for JavaScript/TypeScript
- go test for Go

Cover:
- Happy path
- Edge cases
- Error conditions
- Mock external dependencies
```

**Usage**: `/gen-tests`

### Example 2: PR Description

**File**: `pr-desc.md`
```markdown
Generate a pull request description:

## Summary
[Brief overview of changes]

## Changes
- [Bullet points of key changes]

## Testing
- [How to test these changes]

## Screenshots
[If UI changes]
```

**Usage**: `/pr-desc`

### Example 3: Bug Report Template

**File**: `bug-report.md`
```markdown
Analyze this bug and create a structured report:

**Description**: [What's happening]

**Expected Behavior**: [What should happen]

**Actual Behavior**: [What's actually happening]

**Root Cause**: [Technical explanation]

**Proposed Fix**: [Specific code changes needed]

**Test Plan**: [How to verify the fix]
```

**Usage**: `/bug-report`

## Best Practices

### Naming
- Use kebab-case: `gen-tests`, `code-review`
- Be descriptive: `deploy-checklist` not `deploy`
- Avoid conflicts with built-in commands

### Content
- **Be specific**: Include concrete instructions
- **Add context**: Mention frameworks/tools if relevant
- **Set expectations**: Output format, level of detail
- **Use structure**: Bullet points, sections for clarity

### With File References
Commands can reference files:
```markdown
Review @<file> for:
- Code style matching our standards
- Test coverage
- Documentation completeness
```

Then use: `/code-review @src/main.py`

## Advanced Examples

### Contextual Command

**File**: `commit-msg.md`
```markdown
Generate a commit message from git diff:

Format:
```
type(scope): subject

- Detail 1
- Detail 2

Refs: #issue
```

Types: feat, fix, docs, refactor, test, chore
Keep subject under 50 chars
Use imperative mood
```

### Multi-Step Command

**File**: `full-review.md`
```markdown
Perform a comprehensive review:

1. First, run static analysis
2. Review code quality and patterns
3. Check test coverage
4. Security audit
5. Performance analysis
6. Provide prioritized recommendations
```

## Command Organization

### By Project Type
```
commands/
├── python-review.md
├── js-tests.md
└── go-lint.md
```

### By Task Type
```
commands/
├── review-code.md
├── review-security.md
├── gen-tests.md
├── gen-docs.md
└── explain-code.md
```

## Built-in vs Custom Commands

**Built-in** (system commands):
- `/help`, `/agents`, `/memory`, etc.
- Start with `/`, system functionality

**Custom** (your files):
- `/code-review`, `/gen-tests`, etc.
- Your workflows, your files

## Location

Commands are stored in:
- **Repo**: `~/.me/claude/commands/` (version controlled)
- **Symlink**: `~/.claude/commands/` → `~/.me/claude/commands/`

Create/edit in either location - changes tracked automatically.

## Tips

✅ **Do**:
- Keep commands focused on one task
- Include examples in the command text
- Update commands as standards evolve
- Share useful commands with your team

❌ **Don't**:
- Make commands too vague ("help me code")
- Duplicate built-in Claude capabilities
- Create commands for one-time use
- Forget the file extension (.md)

## Listing Available Commands

```bash
# In Claude session:
/

# From shell:
ls ~/.claude/commands/
```

## Editing Commands

```bash
# From shell:
cd ~/.claude/commands
vim code-review.md

# Or ask Claude:
"Edit the code-review command to include performance checks"
```

## Testing Commands

```bash
# In Claude session:
/my-new-command

# Check if it loads correctly
# Refine based on results
```

## Sharing Commands

Commands in `~/.me/claude/commands/` are version controlled:

```bash
cd ~/.me
git add claude/commands/new-command.md
git commit -m "Add command for API review"
git push

# Team members get it via:
cd ~/.me
git pull
```
