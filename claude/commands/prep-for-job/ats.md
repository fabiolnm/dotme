# ATS Resume Score Analysis

Score your resume against ATS (Applicant Tracking System) criteria.

## Input
$ARGUMENTS

## Instructions

You are an ATS optimization expert. Score the resume against the job description.

**IMPORTANT:** This is a SCORING TOOL ONLY. Score the resume AS-IS. Do not suggest fixes inline. If algorithm calibration is needed, use `/prep-for-job:ats-calibrate` instead.

### Step 1: Gather Inputs

**Resume:** Read the file provided as argument (e.g., `@resume.md`)

**Job Description:** Already available in context from orchestrator

### Step 2: Extract Keywords from Job Description

#### Hard Skills (STRICT extraction)
Parse ALL skill-related terms from JD, including:
- Programming languages, frameworks, databases
- Cloud/Infrastructure, methodologies
- Domain terms: "product development", "user experience", "user needs"
- Work practices: "pair programming", "code review", "TDD"
- Tool names exactly as written

**CRITICAL:** Extract keywords EXACTLY as they appear in the JD. Do not paraphrase.

#### Soft Skills
Parse for collaboration/interpersonal terms:
- Collaboration, teamwork, communication skills
- Leadership, mentoring, cross-functional
- Fast-paced, proactive, attention to detail

### Step 3: Scoring Algorithm

**Total Score: 0-100** from weighted categories:

| Category | Weight | Description |
|----------|--------|-------------|
| Hard Skills Match | 40% | Required technical keywords found |
| Soft Skills Match | 15% | Collaboration/teamwork terms found |
| Searchability | 25% | Contact info, sections, formatting |
| Recruiter Tips | 20% | Experience match, metrics, tone |

#### 3.1 Hard Skills Score (0-40 points)

- List ALL hard skill keywords from JD (typically 15-25 keywords)
- Count: matched / total keywords
- Score = (matched / total) × 40
- Each missing keyword = 1 "issue"

**Matching rules (STRICT - calibrated to Jobscan):**
- Case-insensitive
- Use synonym map below for EXACT equivalents only
- **DO NOT infer matches** - the keyword or its exact synonym must appear verbatim
- Multi-word phrases must match as complete phrases
- Partial matches do NOT count:
  - "product" does NOT match "product development"
  - "user" does NOT match "user experience" or "user needs"
  - "communication" does NOT match "communication skills"
  - "GCP" does NOT match "Google Cloud Platform" (use both if needed)

#### 3.2 Soft Skills Score (0-15 points)

- Score = (matched / total) × 15
- Each missing soft skill = 1 "issue"

**Matching rules (STRICT):**
- Require exact keyword match (case-insensitive)
- Root word matches allowed: "collaborated" matches "collaboration"
- Phrase matches required for multi-word terms:
  - "cross-functional teams" requires "cross-functional" (partial OK)
  - "communication skills" requires exact phrase, not just "communication"
  - "attention to detail" requires exact phrase

#### 3.3 Searchability Score (0-25 points)

| Check | Points | Criteria |
|-------|--------|----------|
| Email present | 3 | Valid email format |
| Phone present | 3 | Phone number visible |
| Full address | 3 | Street + City + State/Province + ZIP/Postal |
| Summary section | 3 | Section header: "Summary" or "Professional Summary" |
| Education section | 3 | Section header: exactly "Education" (not "Education & Learning") |
| Work experience section | 3 | Section header: "Experience" or "Professional Experience" |
| Job title match | 4 | Resume title matches or closely matches JD title |
| Date formatting | 3 | Consistent format: "Mon YYYY - Mon YYYY" or "Mon YYYY - Present" |

**Section header matching (STRICT):**
- Headers must use standard ATS-parseable names
- "Education & Continuous Learning" = FAIL (non-standard)
- "Education" = PASS
- "Work History" = PASS, "Professional Experience" = PASS

**Date formatting (STRICT):**
- Abbreviated months preferred: "Dec 2021" not "December 2021"
- Consistent format throughout
- "Present" or "Current" for ongoing roles

**Address check:**
- "City, State" or "City, Province, Country" = FAIL (incomplete)
- Full street address with city/state/zip = PASS
- Most remote job seekers will fail this check (acceptable)

#### 3.4 Recruiter Tips Score (0-20 points)

| Check | Points |
|-------|--------|
| Measurable results (5+) | 5 |
| Resume tone (no clichés) | 5 |
| Web presence (LinkedIn) | 5 |
| Word count (400-1000) | 3 |
| Job level match | 2 |

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

---

## Hard Skills ([X]/[Y] matched)

### Found
| Keyword (from JD) | Found in Resume |
|-------------------|-----------------|
| TypeScript | ✓ |
| Node.js | ✓ |

### Missing
| Keyword (from JD) | Status |
|-------------------|--------|
| product development | Not found |
| user experience | Not found |

---

## Soft Skills ([X]/[Y] matched)

### Found
| Keyword | Location |
|---------|----------|
| collaboration | Summary |

### Missing
| Keyword | Status |
|---------|--------|
| communication skills | "communication" found but not "communication skills" |

---

## Searchability

| Check | Status | Notes |
|-------|--------|-------|
| Email | ✓ | |
| Phone | ✓ | |
| Full address | ✗ | City only, missing street/zip |
| Summary section | ✓ | |
| Education section | ✗ | Header is "Education & Continuous Learning" |
| Experience section | ✓ | |
| Job title match | ✓ | |
| Date formatting | ✗ | Uses "December" not "Dec" |

---

## Recruiter Tips

| Check | Status |
|-------|--------|
| Measurable results (5+) | ✓ |
| Resume tone | ✓ |
| Web presence | ✓ |
| Word count | ✓ |
| Job level match | ✓ |

---

## Summary

**Score: [XX]/100**

Hard skills gap is the primary issue. [X] keywords from JD not found in resume.
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
- Google Cloud Platform = GCP (ONLY if both forms accepted)

**NOT synonyms (do not match):**
- "product" ≠ "product development"
- "user" ≠ "user experience" ≠ "user needs"
- "communication" ≠ "communication skills"
- "customer" ≠ "customer support"
- "code review" ≠ "reviewing code"
- "pair programming" ≠ "pairing" ≠ "programming"
- "cross-functional" ≠ "teamwork"
- "GCP" ≠ "Google Cloud" (treat as separate keywords)
