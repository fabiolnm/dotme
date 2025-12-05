# Claude Code Prompts

## What Are Prompts?

Prompts are template instructions stored as markdown files. Similar to commands, but typically for less frequent or more specialized use cases. They're reusable prompt templates you can reference when needed.

## When to Use Prompts

- **Occasional complex instructions**: Used a few times per month
- **Specialized workflows**: Domain-specific analysis or generation
- **Template responses**: Structured output formats
- **Experimentation**: Testing new prompting strategies

## Prompts vs Commands

| Feature | Commands | Prompts |
|---------|----------|---------|
| Frequency | Daily/Weekly | Occasional |
| Access | `/command-name` | Copy/paste or reference |
| Purpose | Common workflows | Specialized templates |
| Storage | `.claude/commands/` | `.claude/prompts/` |

## Creating Prompts

Simply create markdown files in this directory:

```bash
cd ~/.claude/prompts
vim my-prompt.md
```

## Simple Examples

### Example 1: Architecture Decision Record

**File**: `adr-template.md`
```markdown
Create an Architecture Decision Record (ADR):

# Title: [Short title of solved problem]

## Status
[Proposed | Accepted | Deprecated | Superseded]

## Context
What is the issue that we're seeing that is motivating this decision?

## Decision
What is the change that we're proposing?

## Consequences
What becomes easier or more difficult because of this change?

## Alternatives Considered
What other options were evaluated?
```

### Example 2: Security Review Checklist

**File**: `security-checklist.md`
```markdown
Perform security review covering:

## Authentication & Authorization
- [ ] Proper authentication checks
- [ ] Role-based access control
- [ ] Session management
- [ ] Password policies

## Input Validation
- [ ] SQL injection prevention
- [ ] XSS prevention
- [ ] CSRF protection
- [ ] File upload validation

## Data Protection
- [ ] Encryption at rest
- [ ] Encryption in transit
- [ ] Sensitive data handling
- [ ] PII compliance

## Infrastructure
- [ ] Security headers
- [ ] HTTPS enforcement
- [ ] Rate limiting
- [ ] Logging & monitoring

Provide findings with severity ratings.
```

### Example 3: API Documentation Generator

**File**: `api-docs.md`
```markdown
Generate comprehensive API documentation:

## Endpoint: [METHOD] /path

### Description
[What this endpoint does]

### Authentication
[Required auth method]

### Request Parameters
| Name | Type | Required | Description |
|------|------|----------|-------------|
| | | | |

### Request Body
```json
{
  "example": "value"
}
```

### Response
**Success (200)**
```json
{
  "result": "data"
}
```

**Error (4xx/5xx)**
```json
{
  "error": "message"
}
```

### Example Usage
```bash
curl -X METHOD url \
  -H "Authorization: Bearer token" \
  -d '{"data": "value"}'
```
```

## Advanced Examples

### Example 4: Performance Analysis

**File**: `perf-analysis.md`
```markdown
Analyze performance characteristics:

## Time Complexity
Analyze algorithmic complexity:
- Best case: O(?)
- Average case: O(?)
- Worst case: O(?)

## Space Complexity
Memory usage analysis:
- Data structures: O(?)
- Auxiliary space: O(?)

## Bottlenecks
Identify performance bottlenecks:
1. [Specific location and reason]
2. [Impact assessment]

## Optimization Opportunities
Concrete suggestions with trade-offs:
1. [Optimization strategy]
   - Expected improvement: [metrics]
   - Cost/complexity: [assessment]
```

### Example 5: Migration Guide

**File**: `migration-guide.md`
```markdown
Create migration guide from [Old] to [New]:

## Overview
Brief summary of changes and benefits

## Breaking Changes
### Change 1: [Title]
**Before:**
```language
// old code
```

**After:**
```language
// new code
```

**Why:** [Explanation]

## Migration Steps
1. [Step 1 with details]
2. [Step 2 with details]
3. [Step 3 with details]

## Compatibility Notes
- Backward compatibility: [Yes/No details]
- Deprecation timeline: [Timeline]

## Common Pitfalls
- [Pitfall 1 and how to avoid]
- [Pitfall 2 and how to avoid]

## Testing Checklist
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Performance benchmarks acceptable
```

## Using Prompts

### Method 1: Reference in Session
```
"Use the API docs template from prompts/ to document this endpoint"
```

### Method 2: Copy/Paste
```bash
# View prompt
cat ~/.claude/prompts/my-prompt.md

# Copy content and paste in Claude session
```

### Method 3: Convert to Command
If you use a prompt frequently, convert it to a command:
```bash
cp ~/.claude/prompts/my-prompt.md ~/.claude/commands/my-command.md
# Now use /my-command
```

## Organization Strategies

### By Domain
```
prompts/
├── security/
│   ├── audit-checklist.md
│   └── threat-model.md
├── architecture/
│   ├── adr-template.md
│   └── system-design.md
└── documentation/
    ├── api-docs.md
    └── readme-template.md
```

### By Output Type
```
prompts/
├── checklists/
├── templates/
├── analyses/
└── generators/
```

## Best Practices

✅ **Do**:
- Include examples in the prompt
- Specify output format clearly
- Add context about when to use
- Update as you refine

❌ **Don't**:
- Make prompts too generic
- Skip structure and formatting
- Forget to test with real data
- Duplicate command functionality

## Prompt Engineering Tips

### Be Specific
```markdown
❌ "Review the code"
✅ "Review for OWASP Top 10 vulnerabilities with specific line numbers"
```

### Set Context
```markdown
This codebase uses:
- Python 3.11 with type hints
- FastAPI for REST APIs
- SQLAlchemy for ORM
```

### Define Output Format
```markdown
Provide response as:
1. Summary (2-3 sentences)
2. Findings (bulleted list)
3. Recommendations (numbered, prioritized)
```

### Include Examples
```markdown
Example output:
**Finding**: SQL injection risk at line 42
**Severity**: Critical
**Fix**: Use parameterized queries
```

## Location

Prompts are stored in:
- **Repo**: `~/.me/claude/prompts/` (version controlled)
- **Symlink**: `~/.claude/prompts/` → `~/.me/claude/prompts/`

Create/edit in either location - changes tracked automatically.

## Sharing Prompts

Prompts in `~/.me/claude/prompts/` are version controlled:

```bash
cd ~/.me
git add claude/prompts/new-prompt.md
git commit -m "Add security audit prompt"
git push
```

Team members get them via:
```bash
cd ~/.me
git pull
```

## Evolution Path

```
Try prompt manually
     ↓
Save as .md in prompts/
     ↓
Refine based on results
     ↓
Use occasionally (months)
     ↓
Use frequently (weekly) → Move to commands/
```
