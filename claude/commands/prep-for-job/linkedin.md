# LinkedIn Accuracy Check

Verify your LinkedIn profile reflects real achievements and skills surfaced during the job application workflow.

## Usage
```
/prep-for-job/linkedin @linkedin-export.pdf
```

## Input
$ARGUMENTS

## Instructions

You are verifying LinkedIn accuracy - NOT optimizing for a specific job. LinkedIn should reflect the true state of the user's career. This step identifies real information that's missing, not job-targeted improvements.

### Step 1: Gather Inputs

**Current LinkedIn Profile:**
- If PDF export provided as argument, read it
- If not provided, prompt: "Please provide your current LinkedIn PDF export"

**Reference Profile:**
- Read `~/job-applications/Profile.md` for the canonical profile structure and content

**Context:** Company name already available from orchestrator.

**Materials from This Workflow:**
- Read from `~/job-applications/[COMPANY_NAME]/`:
  - `RESUME.md`
  - `INTERVIEW_PACKAGE.md` (if exists)
  - `JOB_FIT_ANALYSIS.md` (if exists)

### Step 2: Identify Missing Real Information

Compare LinkedIn against what was discussed during the workflow. Look for:

#### 2.1 Skills Actually Used
- Real skills mentioned in resume/interview prep that aren't on LinkedIn
- Only flag if the skill is genuinely part of their experience

#### 2.2 Achievements Surfaced During Prep
- STAR stories from interview prep that represent real accomplishments
- Quantified results discussed but not on LinkedIn
- Projects mentioned that are missing

#### 2.3 Role/Experience Gaps
- Job responsibilities discussed that aren't reflected
- Recent work that should be added

**CRITICAL: Only flag items that are TRUE and REAL - not job-specific embellishments.**

### Step 3: Generate Findings

When generating update recommendations, follow these formatting rules:

#### LinkedIn About Section Rules
- **Character limit:** 2,600 maximum characters
- **No leading blank spaces** on any line
- **No markdown formatting** (no bold/italic markers)
- **Use Unicode subscripts** where needed (e.g., CO₂)

#### Bullet Point Style (STAR Methodology)
Format experience bullets as: **Situation/Problem → Action → Result**

Example:
```
- Addressed slow release cycles caused by limited test coverage by mentoring the team and building a comprehensive test suite—enabling faster deployments with fewer regressions
```

Pattern: `[Situation] by [Action]—[Result]`

#### Section Structure
1. **Title:** Role | Differentiator, Stack (e.g., "Senior Software Developer | AI DevX Practitioner, Full-Stack")
2. **Summary Paragraph 1:** Lead with differentiator (e.g., AI-augmented development)
3. **Summary Paragraph 2:** Traditional experience and domain expertise
4. **Technical Skills:** Categorized list with AI & Automation first
5. **Key Experience:** STAR-formatted bullets per role

```markdown
# LinkedIn Accuracy Check

**Check Date:** [Date]
**Workflow Reference:** [Company Name]

---

## Result: [Accurate / Updates Needed]

[If accurate:]
Your LinkedIn accurately reflects the experiences and skills discussed during this job application workflow. No updates needed.

[If updates needed:]
The following real information surfaced during this workflow is missing from your LinkedIn:

---

## Missing Items

### Skills to Add
| Skill | Where Surfaced | Why It's Missing |
|-------|----------------|------------------|
| [Skill] | Resume/Interview Prep | Not in LinkedIn skills |

### Achievements to Add
| Achievement | Where Surfaced | Suggested Location |
|-------------|----------------|-------------------|
| [Achievement with metrics] | STAR story | [Company] experience section |

### Experience Updates
| Role | What to Add |
|------|-------------|
| [Company - Title] | [Specific bullet point] |

---

## Suggested About Section Update

**Character Count:** [X]/2,600

[Full suggested About section text, ready to copy-paste to LinkedIn]

---

## What's Already Accurate

Your LinkedIn already includes:
- [Element that matches workflow materials]
- [Element that matches workflow materials]

---

## Action Items

- [ ] [Specific update 1]
- [ ] [Specific update 2]
```

### Step 4: Character Count Validation

Before finalizing recommendations:
1. Count characters in the suggested About section
2. If over 2,600, trim content by:
   - Removing less impactful bullets
   - Shortening STAR results
   - Condensing skills lists
3. Report final character count in output

### Step 5: Save Output

Save to: `~/job-applications/[COMPANY_NAME]/LINKED_IN_ACCURACY_CHECK.md`

This keeps the check tied to the job application that surfaced the suggestions.

### Step 6: Output Summary

**If LinkedIn is accurate:**
```
## LinkedIn Accuracy Check Complete

Your LinkedIn accurately reflects this job application.

No updates needed - your profile already includes the skills and experiences discussed during this workflow.
```

**If updates found:**
```
## LinkedIn Accuracy Check Complete

**Updates Found:** [N] items
**Suggested About Section:** [X]/2,600 characters

These are real experiences/skills from this workflow missing from your LinkedIn:

1. [Item 1] - surfaced during [step]
2. [Item 2] - surfaced during [step]
3. [Item 3] - surfaced during [step]

**Saved to:** ~/job-applications/[company]/LINKED_IN_ACCURACY_CHECK.md
```

### Important Constraints

1. **This is NOT job-specific optimization**
   - LinkedIn should reflect accurate career state
   - Don't suggest headline changes to match a job
   - Don't suggest summary rewrites for targeting

2. **Only flag REAL missing information**
   - Skills the user actually has
   - Achievements that actually happened
   - Experiences that are true

3. **If nothing is missing, say so**
   - Don't suggest changes for the sake of it
   - "Accurate" is a valid outcome

4. **Per-application tracking**
   - Each job application has its own `LINKED_IN_ACCURACY_CHECK.md`
   - Tracks which application surfaced which suggestions
   - Review across applications to see patterns

5. **Respect character limits**
   - LinkedIn About section: 2,600 characters max
   - Always report character count with recommendations
   - Trim content if needed to fit
