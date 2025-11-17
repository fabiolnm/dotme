# Claude Code Agents

## What Are Agents?

Agents are specialized AI personas with specific expertise, behavior, and instructions. They act as domain experts that Claude consults when you need specialized guidance.

## When to Use Agents

- **Domain expertise needed**: Security audits, Python coaching, architecture reviews
- **Consistent review patterns**: Code review standards, testing strategies
- **Role-based guidance**: Acting as a mentor, critic, or specialist
- **Complex workflows**: Multi-step analysis requiring specific knowledge

## Creating Agents

### Quick Start

```bash
# In a Claude session, type:
/agents

# Claude will guide you through creating a new agent
```

### Manual Creation

Create a markdown file in `.claude/agents/`:

```bash
cd ~/.claude/agents
vim my-agent.md
```

### Agent Template

```markdown
---
name: security-auditor
description: Security expert focused on OWASP Top 10 and secure coding
---

You are a security auditor specializing in web application security.

## Your Role

- Review code for OWASP Top 10 vulnerabilities
- Focus on authentication, authorization, and input validation
- Provide specific remediation guidance
- Reference CVEs and security standards

## Analysis Approach

1. Identify attack surface
2. Check for common vulnerabilities
3. Assess security controls
4. Provide actionable recommendations

## Communication Style

- Be direct and precise
- Cite specific vulnerabilities (e.g., "SQL injection via...")
- Rate severity (Critical/High/Medium/Low)
- Include code examples in fixes
```

## Simple Example

**File**: `python-coach.md`

```markdown
---
name: python-coach
description: Teaches Pythonic patterns and best practices
---

You are Guido van Rossum, creator of Python.

Guide the developer to write idiomatic Python:
- Explain why Python does things this way
- Reference PEPs when relevant
- Show modern patterns (type hints, dataclasses)
- Challenge non-Pythonic code with better alternatives
```

## Using Agents

### Option 1: Launch via Task Tool
Claude automatically uses the Task tool to launch appropriate agents when needed.

### Option 2: Manual Request
```
"Review this code as a security auditor"
"Act as the Python coach and review my implementation"
```

## Agent Guidelines

### Naming
- Use kebab-case: `python-coach`, `security-auditor`
- Be descriptive but concise
- Match the expertise area

### Description
- One sentence explaining the agent's purpose
- Helps Claude decide when to invoke it

### Content Structure
1. **Role definition**: Who is this agent?
2. **Expertise**: What do they know?
3. **Approach**: How do they analyze?
4. **Style**: How do they communicate?

## Advanced: Agent with Tools

```markdown
---
name: api-analyzer
description: Analyzes API design and documentation
---

You are an API design expert.

## Tools Available
- Read API specifications
- Test endpoints
- Review documentation
- Check OpenAPI/Swagger schemas

## Analysis Framework
1. Design: RESTful principles, resource naming
2. Security: Authentication, rate limiting
3. Documentation: Completeness, examples
4. Consistency: Status codes, error handling
```

## Tips

✅ **Do**:
- Focus on specific domain expertise
- Include examples in the agent definition
- Be clear about the analysis approach
- Specify communication style

❌ **Don't**:
- Make agents too broad ("general helper")
- Duplicate Claude's base capabilities
- Create agents for simple one-off tasks
- Forget to update as your needs evolve

## Location

Agents are stored in:
- **Repo**: `~/.me/claude/agents/` (version controlled)
- **Symlink**: `~/.claude/agents/` → `~/.me/claude/agents/`

Changes made in either location are automatically tracked for git commit.
