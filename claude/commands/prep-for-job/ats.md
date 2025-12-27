# ATS Resume Score Analysis

Score your resume against ATS (Applicant Tracking System) criteria.

## Input
$ARGUMENTS

## Instructions

You are an ATS optimization expert. Score the resume against the job description.

### Step 1: Gather Inputs

**Resume:** Read the file provided as argument (e.g., `@resume.md`)

**Job Description:** Already available in context from orchestrator

### Step 2: Extract Keywords from Job Description

#### Hard Skills
Parse for technical terms:
- Programming languages, frameworks, databases
- Cloud/Infrastructure, methodologies
- Domain terms, job-specific terms

#### Soft Skills
Parse for collaboration/interpersonal terms:
- Collaboration, teamwork, communication
- Leadership, mentoring, cross-functional

### Step 3: Scoring Algorithm

**Total Score: 0-100** from weighted categories:

| Category | Weight | Description |
|----------|--------|-------------|
| Hard Skills Match | 40% | Required technical keywords found |
| Soft Skills Match | 15% | Collaboration/teamwork terms found |
| Searchability | 25% | Contact info, sections, formatting |
| Recruiter Tips | 20% | Experience match, metrics, tone |

#### 3.1 Hard Skills Score (0-40 points)

- List all hard skill keywords from JD
- Count: matched / total keywords
- Score = (matched / total) × 40
- Each missing keyword = 1 "issue"

**Matching rules (STRICT - calibrated to Jobscan):**
- Case-insensitive
- Use synonym map below for exact equivalents only
- **DO NOT infer matches** - the keyword or its exact synonym must appear in the resume
- "product" does NOT match "product development"
- "customers" does NOT match "customer support"
- "optimized queries" does NOT match "query tuning"
- Multi-word phrases must match as complete phrases

#### 3.2 Soft Skills Score (0-15 points)

- Score = (matched / total) × 15
- Each missing soft skill = 1 "issue"

**Matching rules (STRICT - calibrated to Jobscan):**
- Require exact keyword match (case-insensitive)
- "cross-functional teams" does NOT match "teamwork"
- "collaborated" matches "collaboration" (same root word)

#### 3.3 Searchability Score (0-25 points)

| Check | Points |
|-------|--------|
| Email present | 3 |
| Phone present | 3 |
| Full address (street/city/state/zip) | 3 |
| Summary section | 3 |
| Education section | 3 |
| Work experience section | 3 |
| Job title match | 4 |
| Date formatting | 3 |

**Address check (calibrated to Jobscan):**
- "City, State" or "City, Province, Country" = FAIL (incomplete)
- Full street address with city/state/zip = PASS
- Most remote job seekers will fail this check

#### 3.4 Recruiter Tips Score (0-20 points)

| Check | Points |
|-------|--------|
| Measurable results (5+) | 5 |
| Resume tone (no clichés) | 5 |
| Web presence (LinkedIn) | 5 |
| Word count (400-1000) | 3 |
| Job level match | 2 |

**Job level match (calibrated to Jobscan):**
- Exact match or slightly under = PASS (2 points)
- Overqualified (significantly more experience than required) = WARNING (1 issue, 1 point)
- Underqualified = FAIL (1 issue, 0 points)

### Step 4: Output Score Report

```markdown
# ATS Score Analysis

**Resume:** [File name]
**Job:** [Company] - [Title]
**Date:** [Date]

## Overall Score: [XX]/100

| Category | Issues | Score | Max |
|----------|--------|-------|-----|
| Hard Skills | X | XX | 40 |
| Soft Skills | X | XX | 15 |
| Searchability | X | XX | 25 |
| Recruiter Tips | X | XX | 20 |

## Hard Skills

### Found
| Skill | Resume | JD |
|-------|--------|-----|
| ... | X | X |

### Missing
| Skill | Action |
|-------|--------|
| ... | ... |

## Soft Skills

### Found
- ...

### Missing
- ...

## Searchability

| Check | Status |
|-------|--------|
| ... | ✓/✗ |

## Recruiter Tips

| Check | Status |
|-------|--------|
| ... | ✓/✗/⚠ |

## Priority Fixes

1. [Most impactful]
2. [Second]
3. [Third]
```

### Synonym Map (Exact Equivalents Only)

Technical synonyms (bidirectional matches):
- PostgreSQL = Postgres
- JavaScript = JS
- TypeScript = TS
- Ruby on Rails = Rails = RoR
- Amazon Web Services = AWS
- Test-Driven Development = TDD
- Software as a Service = SaaS
- React.js = React = ReactJS
- Node = Node.js = NodeJS
- CI/CD = continuous integration

**NOT synonyms (do not match):**
- "product" ≠ "product development"
- "customer" / "customers" ≠ "customer support"
- "optimized queries" / "query optimization" ≠ "query tuning"
- "cross-functional" / "teams" ≠ "teamwork"
- "whiteboard" (verb) ≠ "Whiteboards" (product name)
