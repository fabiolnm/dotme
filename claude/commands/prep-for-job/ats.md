# ATS Resume Score Analysis

Score your resume against ATS (Applicant Tracking System) criteria using Jobscan-calibrated algorithm.

## Usage
```
/prep-for-job/ats
/prep-for-job/ats @jobscan-report.pdf
```

## Input
$ARGUMENTS

## Instructions

You are an ATS optimization expert. Analyze the resume against the job description using Jobscan's scoring methodology.

### Step 1: Gather Inputs

**Context:** Company name and job details already available from orchestrator.

**Resume:**
- Read `~/job-applications/[COMPANY_NAME]/RESUME.md`

**Job Description:**
- Already available in context from orchestrator (parsed in Step 1)

**Benchmark File (Optional):**
- If provided as argument or user provides path, read and parse the Jobscan report
- Use benchmark scores as ground truth for calibration

### Step 2: Extract Keywords from Job Description

#### 2.1 Hard Skills Extraction
Parse the job description for technical terms:
- Programming languages (Ruby, Python, JavaScript, etc.)
- Frameworks (Rails, React, Node.js, etc.)
- Databases (PostgreSQL, Redis, Memcached, etc.)
- Cloud/Infrastructure (AWS, Docker, Kubernetes, etc.)
- Methodologies (TDD, Agile, CI/CD, etc.)
- Domain terms (SaaS, API, microservices, etc.)
- Job-specific terms (query tuning, product development, etc.)

#### 2.2 Soft Skills Extraction
Parse for collaboration/interpersonal terms:
- Collaboration, teamwork, communication
- Leadership, mentoring, cross-functional
- Problem-solving, analytical thinking

### Step 3: Scoring Algorithm (Jobscan-calibrated)

**Total Score: 0-100** calculated from weighted categories:

| Category | Weight | Description |
|----------|--------|-------------|
| Hard Skills Match | 40% | Required technical keywords found |
| Soft Skills Match | 15% | Collaboration/teamwork terms found |
| Searchability | 25% | Contact info, sections, formatting |
| Recruiter Tips | 20% | Experience match, metrics, tone |

#### 3.1 Hard Skills Score (0-40 points)

For each hard skill keyword in job description:
1. Count occurrences in resume
2. Score based on match status:
   - **Found (≥1 occurrence):** Full points for that keyword
   - **Missing:** 0 points, flagged as issue

**Calculation:**
- List all hard skill keywords from JD
- Count: matched / total keywords
- Score = (matched / total) × 40
- Each missing keyword = 1 "issue"

**Keyword matching rules (Jobscan-style):**
- Case-insensitive matching
- "Ruby on Rails" matches "Ruby on rails" or "ruby on rails"
- "PostgreSQL" matches "Postgres" (common synonyms)
- Count frequency in resume vs JD requirement

#### 3.2 Soft Skills Score (0-15 points)

For each soft skill in job description:
- Check presence in resume
- Score = (matched / total) × 15
- Each missing soft skill = 1 "issue"

#### 3.3 Searchability Score (0-25 points)

| Check | Points | Criteria |
|-------|--------|----------|
| Email present | 3 | Valid email in contact section |
| Phone present | 3 | Phone number in contact section |
| Address present | 3 | City/State/Country location |
| Summary section | 3 | Professional summary found |
| Education section | 3 | Education heading with content |
| Work experience section | 3 | Experience heading with content |
| Job title match | 4 | JD title appears in profile/summary |
| Date formatting | 3 | Standard MM/YYYY or Month YYYY format |

Missing items = "issues" in searchability category.

#### 3.4 Recruiter Tips Score (0-20 points)

| Check | Points | Criteria |
|-------|--------|----------|
| Measurable results | 5 | 5+ metrics/percentages in bullets |
| Resume tone | 5 | No clichés/buzzwords (results-focused, passionate, etc.) |
| Web presence | 5 | LinkedIn URL included |
| Word count | 3 | 400-1000 words (under is warning, not penalty) |
| Job level match | 2 | Experience years align with role requirements |

**Job Level Match:**
- If overqualified: Warning (not hard penalty)
- If underqualified: Flag as issue

### Step 4: Generate Analysis

```markdown
# ATS Score Analysis

**Resume:** [Company Name] - [Job Title]
**Analysis Date:** [Date]
**Benchmark Used:** [Yes/No - Jobscan]

## Overall Score: [XX]/100

| Category | Issues | Score | Max |
|----------|--------|-------|-----|
| Hard Skills | X issues | XX | 40 |
| Soft Skills | X issue | XX | 15 |
| Searchability | X issues | XX | 25 |
| Recruiter Tips | X issue | XX | 20 |

## Hard Skills Analysis

### Found Keywords
| Skill | Resume Count | JD Count | Status |
|-------|--------------|----------|--------|
| Ruby on Rails | 7 | 3 | ✓ |
| PostgreSQL | 4 | 1 | ✓ |
| ... | ... | ... | ... |

### Missing Keywords (Issues)
| Skill | JD Count | Suggested Action |
|-------|----------|------------------|
| Product development | 1 | Add to experience bullets |
| Query tuning | 1 | Add "optimized queries" language |
| ... | ... | ... |

## Soft Skills Analysis

### Found
- Collaboration (2 mentions)

### Missing
- Teamwork: Add "worked with team" or "team collaboration"

## Searchability Analysis

| Check | Status | Notes |
|-------|--------|-------|
| Email | ✓ | fabio@miranti.net.br |
| Phone | ✓ | 778-998-9780 |
| Address | ✗ | Add city, province/state |
| Summary | ✓ | Found |
| Job Title Match | ✓ | "Lead Ruby on Rails Engineer" in summary |
| ... | ... | ... |

## Recruiter Tips

| Check | Status | Notes |
|-------|--------|-------|
| Measurable Results | ✓ | 5+ metrics found |
| Resume Tone | ✓ | No clichés detected |
| Web Presence | ✓ | LinkedIn included |
| Word Count | ✓ | 528 words (under 1000) |
| Job Level Match | ⚠ | Overqualified - consider context |

## Priority Improvements

### Critical (Missing Hard Skills)
1. Add "product development" - mention in experience bullets
2. Add "query tuning" - change "optimized queries" to "query tuning"
3. Add "customer support" - if applicable from experience
4. Add "Memcached" - if you have experience, add to skills

### Important (Searchability)
1. Add full address (Vancouver, BC, Canada) - not just city

### Nice to Have (Soft Skills)
1. Add "teamwork" language - "collaborated with team" → "teamwork"
```

### Step 5: Compare with Benchmark (if provided)

If Jobscan report provided:
1. Parse their exact scores by category
2. Compare your calculated scores
3. Note any discrepancies
4. Adjust recommendations to match Jobscan's flagged issues exactly

```markdown
## Benchmark Comparison

| Category | Claude Score | Jobscan Score | Delta |
|----------|--------------|---------------|-------|
| Overall | XX | 65 | ±X |
| Hard Skills Issues | X | 7 | ±X |
| Soft Skills Issues | X | 1 | ±X |
| Searchability Issues | X | 2 | ±X |
| Recruiter Tips Issues | X | 1 | ±X |

**Calibration Notes:**
- [Observations about scoring differences]
- [Adjustments made based on Jobscan ground truth]
```

### Step 6: Save Output

Save to: `~/job-applications/[COMPANY_NAME]/ATS_SCORE_ANALYSIS.md`

### Step 7: Save to HubSpot

Create a note on the deal using `hubspot-create-engagement`:

```json
{
  "type": "NOTE",
  "ownerId": [from hubspot-get-user-details],
  "associations": {
    "dealIds": [DEAL_ID]
  },
  "metadata": {
    "body": "<h2>📈 ATS Score: [XX]/100</h2><p>Hard Skills: X issues | Soft Skills: X issues | Searchability: X issues</p>[Full analysis as HTML]"
  }
}
```

### Step 8: Provide Guidance

**If score < 75:**
```
## Action Required

Your ATS score is [XX]/100. Target is 75+.

Top improvements to make:
1. [Most impactful - usually missing hard skills]
2. [Second most impactful]
3. [Third most impactful]

After making changes, run `/prep-for-job/ats` again to re-score.
```

**If score >= 75:**
```
## Ready to Proceed

Your ATS score is [XX]/100. This meets the 75+ threshold.

Minor improvements possible:
- [Any remaining issues]
```

### Jobscan Keyword Synonym Map

Common synonyms to treat as matches:
- PostgreSQL = Postgres
- JavaScript = JS
- TypeScript = TS
- Ruby on Rails = Rails = RoR
- Amazon Web Services = AWS
- Continuous Integration = CI
- Continuous Deployment = CD
- Test-Driven Development = TDD
- Application Programming Interface = API
- Software as a Service = SaaS

### Important Notes

1. **Match Jobscan's issue counting** - Each missing keyword = 1 issue
2. **Be specific** - Say "add 'query tuning' to line about database optimization"
3. **Prioritize hard skills** - They have the most weight (40%)
4. **Use benchmark** - If Jobscan report provided, align with their findings
