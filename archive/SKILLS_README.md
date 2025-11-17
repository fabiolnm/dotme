# Claude Code Skills

## What Are Skills?

Skills are sophisticated, multi-step workflows with access to tools and programming logic. They're more powerful than commands - think of them as mini-applications that Claude can execute.

## When to Use Skills

- **Complex multi-step workflows**: PDF processing, data analysis, file transformations
- **Tool integration**: Need to read files, run commands, process outputs
- **Conditional logic**: Different paths based on inputs or results
- **Stateful operations**: Track progress across multiple steps
- **Specialized domains**: Calculations, format conversions, structured analysis

## Skills vs Commands vs Prompts

| Feature | Commands | Prompts | Skills |
|---------|----------|---------|--------|
| Complexity | Simple | Simple | Complex |
| Tools | No | No | Yes |
| Logic | No | No | Yes |
| Structure | Markdown | Markdown | Directory + frontmatter |
| Use case | Quick prompts | Templates | Workflows |

## Creating Skills

### Structure Requirement
Skills must be in a directory with a `SKILL.md` file:

```
skill-name/
└── SKILL.md
```

### Basic Skill Template

**Directory**: `calculating-ev-tco/`
**File**: `calculating-ev-tco/SKILL.md`

```markdown
---
name: calculating-ev-tco
description: Calculate total cost of ownership for electric vs gas vehicles over specified period
---

# EV vs Gas Vehicle TCO Calculator

## What This Does
Compares total cost of ownership between electric and gas vehicles.

## Inputs Required
- Vehicle purchase prices
- Fuel/electricity costs
- Maintenance estimates
- Insurance rates
- Time period (years)

## Calculation Process
1. Gather vehicle specifications
2. Calculate fuel costs
3. Calculate maintenance costs
4. Add insurance and fees
5. Compute total ownership cost
6. Present comparison

## Output Format
Detailed breakdown with:
- Initial costs
- Operating costs (yearly)
- Total cost over period
- Cost per mile
- Break-even analysis
```

### Naming Conventions

**Format**: kebab-case with gerund form (verb + -ing)

✅ **Good Examples**:
- `processing-pdfs`
- `analyzing-spreadsheets`
- `managing-databases`
- `testing-code`
- `writing-documentation`

❌ **Bad Examples**:
- `pdf-processor` (not gerund)
- `ProcessPDFs` (not kebab-case)
- `pdf_analysis` (snake_case, not gerund)

### Frontmatter Requirements

```yaml
---
name: skill-name
description: Brief description (max 1024 chars)
---
```

- **name**: Must match directory name, kebab-case, gerund form
- **description**: Clear explanation of what skill does and when to use it

## Simple Examples

### Example 1: File Analyzer

**Directory**: `analyzing-codebase-structure/`
**File**: `SKILL.md`

```markdown
---
name: analyzing-codebase-structure
description: Analyzes codebase structure, generates directory tree, identifies patterns, and provides architectural insights
---

# Codebase Structure Analyzer

## Process
1. Read directory structure
2. Identify file types and patterns
3. Detect frameworks and tools
4. Analyze organization
5. Generate insights

## Output
- Directory tree visualization
- File type distribution
- Detected patterns
- Architectural observations
- Recommendations
```

### Example 2: Data Transformer

**Directory**: `converting-data-formats/`
**File**: `SKILL.md`

```markdown
---
name: converting-data-formats
description: Converts data between formats (JSON, CSV, YAML, XML) with validation and error handling
---

# Data Format Converter

## Supported Formats
- JSON ↔ CSV
- JSON ↔ YAML
- CSV ↔ JSON
- XML ↔ JSON

## Process
1. Read input file
2. Validate format
3. Parse data
4. Transform to target format
5. Validate output
6. Write result

## Error Handling
- Invalid syntax detection
- Schema validation
- Data type conversion
- Error reporting
```

## Advanced Example: Testing Workflow

**Directory**: `testing-code/`
**File**: `SKILL.md`

```markdown
---
name: testing-code
description: Comprehensive testing workflow including test generation, execution, coverage analysis, and reporting
---

# Code Testing Workflow

## Steps

### 1. Test Discovery
- Identify testable code
- Check existing test coverage
- Find untested paths

### 2. Test Generation
- Generate unit tests
- Create integration tests
- Add edge case tests

### 3. Test Execution
- Run test suite
- Capture results
- Identify failures

### 4. Coverage Analysis
- Measure code coverage
- Identify gaps
- Prioritize improvements

### 5. Reporting
- Summary of results
- Coverage metrics
- Recommendations

## Tools Used
- Read: Examine source and test files
- Bash: Execute test commands
- Grep: Find patterns in code
- Write: Generate new tests

## Output Format
```
Test Results Summary
├── Passed: X tests
├── Failed: Y tests
├── Coverage: Z%
└── Recommendations:
    - Area 1 needs tests
    - Area 2 has low coverage
```
```

## Using Skills

### Invoke by Name
```
"Use the calculating-ev-tco skill to compare these two vehicles"
```

### Claude Auto-Invokes
Claude may automatically use relevant skills when appropriate.

### List Available Skills
```bash
ls ~/.claude/skills/
```

## Skill Development Process

### 1. Design Phase
- Define clear purpose
- List required inputs
- Outline steps
- Identify tools needed

### 2. Implementation
- Create directory structure
- Write SKILL.md with frontmatter
- Document process clearly
- Add examples

### 3. Testing
- Test with real data
- Refine error handling
- Improve output format
- Update documentation

### 4. Iteration
- Gather feedback
- Add features
- Optimize performance
- Update docs

## Best Practices

### Do's ✅
- **Single responsibility**: One skill, one purpose
- **Clear documentation**: Explain what, why, how
- **Example outputs**: Show expected results
- **Error handling**: Document failure cases
- **Incremental steps**: Break complex workflows into phases

### Don'ts ❌
- **Too broad**: "analyze-everything"
- **Unclear naming**: Avoid generic names
- **Missing documentation**: Explain the process
- **No examples**: Always include use cases
- **Ignore errors**: Plan for failure scenarios

## Tool Access

Skills have access to Claude Code tools:
- **Read**: Read files
- **Write**: Write files
- **Edit**: Modify files
- **Bash**: Execute commands
- **Grep**: Search code
- **Glob**: Find files

Example tool usage in skill:
```markdown
## Process
1. Use Glob to find all Python files
2. Use Read to examine each file
3. Use Grep to find test patterns
4. Use Write to create test report
```

## Skill Organization

### By Domain
```
skills/
├── analyzing-security/
├── processing-pdfs/
├── managing-databases/
└── testing-code/
```

### By Tool Focus
```
skills/
├── file-operations/
│   ├── converting-formats/
│   └── processing-pdfs/
└── code-analysis/
    ├── analyzing-structure/
    └── testing-code/
```

## Location

Skills are stored in:
- **Repo**: `~/.me/claude/skills/` (version controlled)
- **Symlink**: `~/.claude/skills/` → `~/.me/claude/skills/`

Each skill is a directory with `SKILL.md` inside.

## Sharing Skills

Skills in `~/.me/claude/skills/` are version controlled:

```bash
cd ~/.me
git add claude/skills/my-skill/
git commit -m "Add skill for data analysis"
git push
```

Team members get them via:
```bash
cd ~/.me
git pull
```

## Debugging Skills

### Test Skill Structure
```bash
# Check directory structure
ls -la ~/.claude/skills/my-skill/

# Verify SKILL.md exists
cat ~/.claude/skills/my-skill/SKILL.md
```

### Validate Frontmatter
```yaml
---
name: my-skill           # Must match directory name
description: What it does  # Required
---
```

### Test Execution
```
"Use the my-skill skill with this input..."
# Watch for errors in output
```

## Evolution Path

```
Manual workflow
     ↓
Document as prompt
     ↓
Convert to command (if frequent)
     ↓
Evolve to skill (if needs tools/logic)
     ↓
Refine and optimize
```

## Reference

Official docs: https://code.claude.com/docs/en/skills.md

## Examples to Study

Look at existing skills for inspiration:
```bash
ls ~/.claude/skills/
```

Common patterns:
- Multi-step analysis workflows
- Data transformation pipelines
- Testing and validation suites
- Report generation workflows
