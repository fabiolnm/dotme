# Prepare Full Job Application Package

Orchestrate the complete job application workflow: from CRM entry to interview preparation.

## Usage
```
/prep-for-job @linkedin.pdf JOB_DESCRIPTION
```

## Input
$ARGUMENTS

## Instructions

You are a job application orchestrator. Guide the user through the complete pipeline, executing each step in sequence.

### Overview

This command runs the full job application pipeline:

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  1. Parse Job → 2. Research → 3. Score Fit → 4. Resume → 5. ATS Score →      │
│  6. Cover Letter → 7. Interview Prep → 8. LinkedIn Suggestions               │
└──────────────────────────────────────────────────────────────────────────────┘
```

**Output:** `~/job-applications/[COMPANY_NAME]/`

### Step 0: Validate Inputs

**Required:**
- LinkedIn PDF export (for scoring and resume generation)
- Job description (posting, recruiter message, or URL)

If LinkedIn PDF not provided:
```
Please provide your LinkedIn PDF export:
/prep-for-job @your-linkedin.pdf [JOB_DESCRIPTION]
```

### Step 1: Parse Job & Store in HubSpot

Execute the `/prep-for-job/parse` workflow:
- Extract job details (title, company, tech stack, compensation, etc.)
- Create/link HubSpot records (deal, company, contact)
- Log job description as note
- Research compensation if not provided

**Checkpoint:** Confirm deal created, show HubSpot link.

### Step 2: Research Company

Execute the `/prep-for-job/research` workflow:
- Parallel research: website, blog, YouTube, Glassdoor, news, LinkedIn
- Compile findings into structured document
- Present summary and gaps
- Ask for additional materials from user
- Create `COMPANY_RESEARCH.md`

**Checkpoint:** Confirm research saved, show key insights.

### Step 3: Calculate Job-Fit Score

Execute the `/prep-for-job/fit` workflow:
- Read `COMPANY_RESEARCH.md` for industry/company context
- Score match (0-10) across 5 criteria
- Create `JOB_FIT_ANALYSIS.md`
- Store scores in HubSpot

**Checkpoint:** Show fit score breakdown.

```
Fit Score: [X.X]/10
- Title Match: X.X/2.0
- Tech Stack: X.X/3.0
- Experience: X.X/2.0
- Industry: X.X/1.5
- Seniority: X.X/1.5

[If score < 5.0, ask: "Fit score is low. Continue anyway?"]
```

### Step 4: Generate Optimized Resume

Execute the `/prep-for-job/resume` workflow:
- Generate ATS-optimized resume following CV guidelines
- Apply STAR method to experience bullets
- Highlight AI/Claude Code achievements
- Create `RESUME.md` and `.pdf`

**Checkpoint:** Confirm resume generated, show path.

**Ask clarifying questions:**
- Specific achievements to highlight for this role?
- Any AI-assisted development work to feature? (e.g., Claude Code workflows, productivity gains from AI pair programming, automated code generation)

### Step 5: Score Against ATS

Execute the `/prep-for-job/ats` workflow:
- Score resume (0-100)
- Suggest resume improvements for missing keywords
- Create `ATS_SCORE_ANALYSIS.md`

**Checkpoint:** Show ATS score.

```
ATS Score: [XX]/100
- Hard Skills: X issues
- Soft Skills: X issues
- Searchability: X issues
- Recruiter Tips: X issues

[If score < 75]
Top improvements needed:
1. [Missing keyword 1]
2. [Missing keyword 2]
3. [Searchability fix]

Would you like to:
(a) Apply suggested improvements and re-score
(b) Continue anyway (not recommended)
```

**Loop until score >= 75 or user chooses to continue.**

### Step 5b: Human Review Gate

**STOP and wait for explicit approval before proceeding.**

Present the current state:
```
## Resume & ATS Review Checkpoint

**Resume:** RESUME.md / RESUME.pdf
**ATS Score:** [XX]/100
**Calibration:** [Done/Skipped]

Please review the generated resume and ATS analysis.

Are you satisfied with:
1. Resume content and formatting?
2. ATS score and keyword coverage?
3. Algorithm calibration (if performed)?

Reply:
(a) Yes, proceed to cover letter
(b) Regenerate resume with feedback: [your feedback]
(c) Re-run ATS scoring
(d) Calibrate ATS algorithm (provide Jobscan report)
```

**Do NOT proceed to Step 6 until user explicitly approves (option a).**

**If user selects (d) - Calibrate ATS algorithm:**
1. User provides Jobscan benchmark report (e.g., `@jobscan-report.pdf`)
2. Execute `/prep-for-job/ats-calibrate @RESUME.md @jobscan-report.pdf`
3. Calibration compares Claude vs Jobscan scores
4. If discrepant, updates `/ats` command algorithm
5. Re-run Step 5 with calibrated algorithm
6. Return to this review gate

If user provides other feedback, loop back to Step 4 or Step 5 as needed.

### Step 6: Generate Cover Letter

Execute the `/prep-for-job/cover-letter` workflow:
- Use company research from Step 2 to tailor the letter
- Reference specific insights (mission, recent news, tech stack, culture)
- Generate personalized cover letter
- Create `COVER_LETTER.md` and `.pdf`

**Leverage Step 2 research:**
- Company mission/values → Opening paragraph hook
- Recent news/launches → Show you're informed
- Engineering blog insights → Technical alignment
- Glassdoor culture notes → Values alignment

**Ask personalization questions:**
- Why are you interested in [COMPANY] specifically? (beyond what research found)
- Any specific project, team, or initiative you want to address?
- Do you have a referral or connection at the company?

**Checkpoint:** Confirm cover letter generated, show which research was incorporated.

### Step 7: Generate Interview Preparation Package

Execute the `/prep-for-job/interview` workflow:
- Use `COMPANY_RESEARCH.md` from Step 2
- Prepare technical topics based on job requirements
- Create STAR stories from your experience
- Build storytelling guide
- Generate questions to ask
- Create 1-week prep schedule
- Create `INTERVIEW_PACKAGE.md` and `.pdf`

**Extract from research:** Interview stages from Glassdoor/job description. Confirm with user.

**Ask clarifying questions:**
- Any specific experiences you want to highlight?
- What's your biggest concern about this interview?

**Checkpoint:** Confirm package generated.

### Step 8: LinkedIn Accuracy Check

Execute the `/prep-for-job/linkedin` workflow:
- Compare LinkedIn profile against real achievements/skills surfaced during this workflow
- Identify missing updates: real experiences discussed that should be on LinkedIn but aren't
- This is NOT job-specific optimization - LinkedIn should reflect accurate career state

**Present findings:**
- If gaps found: List specific missing items with "Add [X] - surfaced during [step]"
- If no gaps: "Your LinkedIn accurately reflects this job application."
- Save to `LINKED_IN_ACCURACY_CHECK.md`

**Checkpoint:** Confirm LinkedIn review complete.

### Final Summary

```
## Job Application Package Complete

**Position:** [Job Title] at [Company]
**HubSpot Deal:** [Link]

### Scores
| Metric | Score |
|--------|-------|
| Job Fit | X.X/10 |
| ATS | XX/100 |

### Files Generated
~/job-applications/[company]/
├── COMPANY_RESEARCH.md
├── JOB_FIT_ANALYSIS.md
├── ATS_SCORE_ANALYSIS.md
├── RESUME.md
├── RESUME.pdf
├── COVER_LETTER.md
├── COVER_LETTER.pdf
├── INTERVIEW_PACKAGE.md
├── INTERVIEW_PACKAGE.pdf
└── LINKED_IN_ACCURACY_CHECK.md

### Application Checklist
- [x] Job stored in CRM
- [x] Company researched
- [x] Fit analysis complete
- [x] Resume optimized (ATS: XX/100)
- [x] Cover letter personalized
- [x] Interview prep ready
- [x] LinkedIn suggestions noted

### Next Steps
1. Review all generated documents for accuracy
2. Submit application with RESUME.pdf and COVER_LETTER.pdf
3. Follow 1-week prep schedule in INTERVIEW_PACKAGE.pdf
4. Update LinkedIn based on suggestions (optional)

Good luck! 🎯
```

### Important Constraints

1. **NEVER FABRICATE** - All content must be from LinkedIn profile or user-confirmed
2. **Ask questions** - Pause at each step to gather needed context
3. **Show progress** - Confirm each step completion before proceeding
4. **Allow iteration** - Let user refine resume/ATS until satisfied
5. **Be thorough** - This is a comprehensive prep, take time to do it right
