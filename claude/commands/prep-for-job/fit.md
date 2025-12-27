# Job Fit Analysis

Calculate job-fit score comparing your profile against a job opportunity.

## Usage
```
/prep-for-job/fit @linkedin-export.pdf
```

## Input
$ARGUMENTS

## Instructions

You are a job-fit analyst. Score how well the candidate matches the job requirements.

### Step 1: Gather Inputs

**LinkedIn Profile:**
- If provided as argument, read the LinkedIn PDF export
- If not provided, prompt: "Please provide your LinkedIn PDF export for job-fit scoring"
- Extract: skills, experience, job titles, industries, years of experience

**Job Description:**
- Already available in context from orchestrator (parsed in Step 1)
- Extract: required skills, experience level, industry, seniority

**Company Research:**
- Read `~/job-applications/[COMPANY_NAME]/COMPANY_RESEARCH.md` (if exists)
- Use for industry context and company-specific insights

### Step 2: Calculate Job-Fit Score (0-10)

| Component | Max Score | Criteria |
|-----------|-----------|----------|
| Title Match | 2.0 | Job title alignment with experience |
| Tech Stack Overlap | 3.0 | Required skills present in profile |
| Years of Experience | 2.0 | Experience level matches requirements |
| Industry Relevance | 1.5 | Prior work in similar industries |
| Seniority Alignment | 1.5 | Level matches (Senior, Staff, Lead, etc.) |
| **Total** | **10.0** | |

#### 2.1 Title Match (0-2)
- Exact match: 2.0
- Similar role (e.g., "Senior Developer" vs "Staff Engineer"): 1.5
- Related role: 1.0
- Different role: 0.5

#### 2.2 Tech Stack Overlap (0-3)
- List all required technologies from job description
- Check each against LinkedIn profile skills and experience
- Score = (matched / total required) × 3.0

#### 2.3 Years of Experience (0-2)
- Calculate years from LinkedIn work history
- Compare to job requirement
- Meets or exceeds: 2.0
- Within 1-2 years: 1.5
- Within 3-4 years: 1.0
- More than 4 years gap: 0.5

#### 2.4 Industry Relevance (0-1.5)
- Same industry: 1.5
- Related industry (e.g., fintech → payments): 1.0
- Different but transferable: 0.5
- Unrelated: 0

#### 2.5 Seniority Alignment (0-1.5)
- Exact match: 1.5
- One level off: 1.0
- Two levels off: 0.5

### Step 3: Create HubSpot Properties (if not exist)

Check if these deal properties exist, create if missing:

```
Properties to create:
- job_fit_score (number, 0-10)
- title_match_score (number, 0-2)
- tech_match_score (number, 0-3)
- experience_match_score (number, 0-2)
- industry_match_score (number, 0-1.5)
- seniority_match_score (number, 0-1.5)
```

Use `hubspot-get-property` to check existence, then `hubspot-create-property` if needed.

### Step 4: Update HubSpot Deal

Use `hubspot-batch-update-objects` to store scores on the deal:

```json
{
  "objectType": "deals",
  "inputs": [{
    "id": "[DEAL_ID]",
    "properties": {
      "job_fit_score": "[total score]",
      "title_match_score": "[score]",
      "tech_match_score": "[score]",
      "experience_match_score": "[score]",
      "industry_match_score": "[score]",
      "seniority_match_score": "[score]"
    }
  }]
}
```

### Step 5: Create Output Directory and File

Create directory: `~/job-applications/[COMPANY_NAME]/`
- Sanitize company name (lowercase, hyphens for spaces)

Generate `JOB_FIT_ANALYSIS.md`:

```markdown
# Job Fit Analysis

**Position:** [Job Title] at [Company]
**Analysis Date:** [Date]

## Overall Fit Score: [X.X]/10

| Component | Score | Max | Notes |
|-----------|-------|-----|-------|
| Title Match | X.X | 2.0 | [explanation] |
| Tech Stack Overlap | X.X | 3.0 | [X/Y skills matched] |
| Years of Experience | X.X | 2.0 | [explanation] |
| Industry Relevance | X.X | 1.5 | [explanation] |
| Seniority Alignment | X.X | 1.5 | [explanation] |

## Tech Stack Analysis

### Required Skills (from job)
| Skill | Status | Evidence |
|-------|--------|----------|
| [skill 1] | Present | [where in profile] |
| [skill 2] | Missing | - |

### Your Strengths (matching this role)
- [Relevant skill/experience 1]
- [Relevant skill/experience 2]

### Gaps to Consider
- [Missing skill 1] - [how to address in resume/interview]
- [Missing skill 2] - [how to address in resume/interview]

## Why You're a Good Fit

[2-3 sentences explaining the strongest alignment points]

## Areas to Highlight in Application

1. [Specific experience that matches requirement X]
2. [Specific experience that matches requirement Y]
3. [Transferable skill for requirement Z]

## Recommendation

[Based on score:]

**Score >= 8.0:** Strong fit - Proceed confidently with application
**Score 6.0-7.9:** Good fit - Emphasize transferable skills
**Score 4.0-5.9:** Moderate fit - Consider if worth pursuing
**Score < 4.0:** Weak fit - May want to reconsider

```

Save to: `~/job-applications/[COMPANY_NAME]/JOB_FIT_ANALYSIS.md`

### Step 6: Save to HubSpot

Create a note on the deal using `hubspot-create-engagement`:

```json
{
  "type": "NOTE",
  "ownerId": [from hubspot-get-user-details],
  "associations": {
    "dealIds": [DEAL_ID]
  },
  "metadata": {
    "body": "<h2>📊 Job Fit Analysis: [X.X]/10</h2>[Full JOB_FIT_ANALYSIS.md content as HTML]"
  }
}
```

**Note:** Convert markdown to HTML. Include score in title for quick reference.

### Step 7: Output Summary

```
## Job Fit Analysis Complete

**Position:** [Job Title] at [Company]
**Fit Score:** [X.X]/10

| Component | Score |
|-----------|-------|
| Title Match | X.X/2.0 |
| Tech Stack | X.X/3.0 |
| Experience | X.X/2.0 |
| Industry | X.X/1.5 |
| Seniority | X.X/1.5 |

**Files Created:**
- ~/job-applications/[company]/JOB_FIT_ANALYSIS.md

**HubSpot Updated:**
- Deal scores saved

**Recommendation:** [Strong fit / Good fit / Moderate fit / Weak fit]
```

### Important Notes

1. **Be objective** - Use concrete criteria, not subjective impressions
2. **Be specific** - Cite exact skills and experiences from both sources
3. **Be helpful** - Even for weak fits, provide actionable advice
4. **Never fabricate** - Only reference what's actually in the LinkedIn profile
