# Generate Cover Letter

Generate a personalized cover letter for a job application.

## Usage
```
/prep-for-job/cover-letter
```

## Input
$ARGUMENTS

## Instructions

You are an expert cover letter writer who creates compelling, personalized letters that complement resumes.

### Step 1: Gather Context

**Context:** Company name and job details already available from orchestrator.

**Read from existing files:**
- `~/job-applications/[COMPANY_NAME]/COMPANY_RESEARCH.md`
- `~/job-applications/[COMPANY_NAME]/RESUME.md`
- `~/job-applications/[COMPANY_NAME]/JOB_FIT_ANALYSIS.md` (if exists)

**Ask personalization questions:**

1. "Why are you interested in [COMPANY_NAME] specifically?"
   - What excites you about their product/mission?
   - Any connection to their industry/values?

2. "Is there a specific project or achievement you want to highlight?"
   - Something not fully covered in resume
   - A story that shows your fit

3. "Do you know anyone at the company or have any referral?"

4. "Any specific team, product, or challenge mentioned in the job posting you want to address?"

### Step 2: Read Company Research

**Read from:** `~/job-applications/[COMPANY_NAME]/COMPANY_RESEARCH.md`

Extract for the cover letter:
- Company mission/values → Opening paragraph hook
- Recent news or product launches → Show you're informed
- Tech stack/engineering culture → Technical alignment
- Key challenges in their industry → How you can help

### Step 3: Generate Cover Letter

**CRITICAL: Only reference REAL experience from the resume or user-confirmed information.**

#### Structure (3-4 paragraphs, < 400 words):

**Opening Paragraph (2-3 sentences):**
- Hook: Start with something specific about the company (not generic)
- Position: State the role you're applying for
- Connection: Brief why you're a fit

Example: "When I learned that [Company] is [specific initiative/challenge], I immediately saw an opportunity to contribute. As a [Your Title] with [X years] of experience in [relevant area], I'm excited to apply for the [Job Title] position."

**Body Paragraph 1 (3-4 sentences):**
- STAR achievement that maps to a key requirement
- Quantified results
- Why this matters for the role

**Body Paragraph 2 (3-4 sentences):**
- Second STAR achievement OR
- Specific technical/domain expertise relevant to role
- How you'd apply this at the company

**Closing Paragraph (2-3 sentences):**
- Reiterate enthusiasm
- Mention availability for interview
- Thank them

**Sign-off:**
```
Best regards,

[Full Name]
[Phone]
[Email]
```

#### Tone Guidelines:
- Professional but personable
- Confident but not arrogant
- Specific, not generic
- Active voice
- No clichés ("I'm a team player", "hard worker")

### Step 4: Review Against Anti-Patterns

Check the letter does NOT have:
- [ ] Generic opening ("I am writing to apply for...")
- [ ] Repeating the resume verbatim
- [ ] No specific company mention
- [ ] No quantified achievements
- [ ] More than 1 page
- [ ] Typos or grammatical errors
- [ ] Fabricated information

### Step 5: Save

Save to: `~/job-applications/[COMPANY_NAME]/COVER_LETTER.md`

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
    "body": "<h2>✉️ Cover Letter</h2>[Full COVER_LETTER.md content as HTML]"
  }
}
```

**Note:** Convert markdown to HTML for better rendering in HubSpot.

### Step 7: Output Summary

```
## Cover Letter Generated

**Position:** [Job Title] at [Company]

**Files Created:**
- ~/job-applications/[company]/COVER_LETTER.md

**Key Points Highlighted:**
1. [Achievement 1 - mapped to requirement X]
2. [Achievement 2 - mapped to requirement Y]

**Company Connection:** [What you mentioned about why this company]
```

### Important Constraints

1. **NEVER FABRICATE** - Every claim must be from the resume or user-confirmed
2. **Be specific** - Generic letters get ignored
3. **Complement, don't repeat** - Add context the resume can't convey
4. **Show genuine interest** - Research the company, mention specifics
5. **Keep it short** - Hiring managers skim; respect their time
