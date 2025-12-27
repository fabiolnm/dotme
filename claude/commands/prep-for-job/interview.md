# Generate Interview Preparation Package

Create a comprehensive 1-week interview preparation plan tailored to the specific job.

## Usage
```
/interview-package
```

## Input
$ARGUMENTS

## Instructions

You are an expert interview coach for software engineering roles. Create a thorough preparation package.

### Step 1: Gather Context

**Read existing files:**
- `~/job-applications/[COMPANY_NAME]/COMPANY_RESEARCH.md`
- `~/job-applications/[COMPANY_NAME]/RESUME.md`
- `~/job-applications/[COMPANY_NAME]/JOB_FIT_ANALYSIS.md` (if exists)
- `~/job-applications/[COMPANY_NAME]/COVER_LETTER.md` (if exists)
- Job description from HubSpot deal

**Note:** `COMPANY_RESEARCH.md` contains mission, values, tech stack, recent news, Glassdoor insights, and key people - use this for the Company Research section of the interview package.

**Extract interview process:**
- From `COMPANY_RESEARCH.md` → Glassdoor interview process section
- From job description → any mentioned stages or timeline
- If not found, search: "[COMPANY_NAME] interview process software engineer"

Present findings: "Based on research, [COMPANY] typically has: [stages]. Does this match what you've been told?"

**Ask clarifying questions:**

1. "Any specific experiences from your career you'd like to highlight?"
   - Leadership moments?
   - Technical challenges overcome?
   - Conflict resolution?
   - Failures and learnings?

3. "What's your biggest concern about this interview?"

### Step 2: Generate Interview Package

**CRITICAL: Only prepare stories from REAL experiences. Never fabricate.**

Create the following sections:

---

## 1. Company Research

### About [Company Name]
- **What they do:** [Products/services]
- **Founded:** [Year]
- **Size:** [Employees, funding stage]
- **Mission:** [Company mission/values]
- **Tech stack:** [Known technologies]

### Recent News
- [News item 1 with date]
- [News item 2 with date]
- [News item 3 with date]

### Why This Role Matters
- [How this role fits into company goals]
- [Team structure if known]

### Key Challenges They Likely Face
1. [Challenge 1 - how you can help]
2. [Challenge 2 - how you can help]

---

## 2. Technical Preparation

### Core Topics Based on Job Requirements

#### Data Structures & Algorithms
Based on the role, focus on:
- [ ] [Topic 1] - Why: [relevance to job]
- [ ] [Topic 2] - Why: [relevance to job]
- [ ] [Topic 3] - Why: [relevance to job]

**Practice Problems:**
1. [LeetCode/problem link or description]
2. [LeetCode/problem link or description]
3. [LeetCode/problem link or description]

#### System Design (if applicable)
Topics to review:
- [ ] [System design topic 1]
- [ ] [System design topic 2]

**Practice Scenarios:**
1. "Design a [system relevant to company]"
2. "Scale [feature from their product]"

#### Tech Stack Deep Dive
Based on job requirements, review:
- [ ] [Technology 1]: [specific areas to focus]
- [ ] [Technology 2]: [specific areas to focus]

#### Code Review/Debugging
Prepare for:
- Reading unfamiliar code
- Identifying bugs and improvements
- Discussing trade-offs

---

## 3. Behavioral Preparation (STAR Stories)

**IMPORTANT: These must be YOUR real experiences. Review and personalize.**

### Story Bank

For each story, structure as:
- **Situation:** Context
- **Task:** Your responsibility
- **Action:** What YOU did (focus on your contributions)
- **Result:** Quantified outcome

#### Leadership / Influence

**Story: [Title from your experience]**
- S: [Situation]
- T: [Task]
- A: [Action]
- R: [Result]

*Use for questions like:* "Tell me about a time you led a team/project"

#### Technical Challenge

**Story: [Title from your experience]**
- S: [Situation]
- T: [Task]
- A: [Action]
- R: [Result]

*Use for questions like:* "Describe a difficult technical problem you solved"

#### Conflict Resolution

**Story: [Title from your experience]**
- S: [Situation]
- T: [Task]
- A: [Action]
- R: [Result]

*Use for questions like:* "Tell me about a time you disagreed with a colleague"

#### Failure / Learning

**Story: [Title from your experience]**
- S: [Situation]
- T: [Task]
- A: [Action - including what went wrong]
- R: [What you learned and changed]

*Use for questions like:* "Tell me about a time you failed"

#### Impact / Achievement

**Story: [Title from your experience]**
- S: [Situation]
- T: [Task]
- A: [Action]
- R: [Result with metrics]

*Use for questions like:* "What's your proudest achievement?"

---

## 4. Storytelling - Selling Your Expertise

### Your Elevator Pitch (30 seconds)
"[Crafted pitch based on resume and job fit]"

### Why You? (3 key differentiators)
1. **[Differentiator 1]:** [How it helps them]
2. **[Differentiator 2]:** [How it helps them]
3. **[Differentiator 3]:** [How it helps them]

### Why This Company? (Genuine reasons)
- [Reason 1 - specific to company]
- [Reason 2 - specific to role/team]
- [Reason 3 - career alignment]

### Addressing Potential Concerns
If they ask about [potential gap], respond with:
"[Prepared response that reframes positively]"

---

## 5. Questions to Ask

### For Hiring Manager
1. "What does success look like in this role after 90 days?"
2. "What are the biggest challenges the team is facing right now?"
3. "How does this role contribute to [company goal/product]?"

### For Team Members
1. "What's your favorite part about working here?"
2. "How does the team handle technical decisions and disagreements?"
3. "What's the code review process like?"

### For Technical Interviewers
1. "What's the most interesting technical challenge you've worked on recently?"
2. "How do you balance technical debt with feature development?"

### About Growth
1. "What learning opportunities are available?"
2. "How has the team evolved over the past year?"

---

## 6. One-Week Preparation Schedule

### Day 1-2: Foundation
- [ ] Complete company research
- [ ] Review job description in detail
- [ ] Identify key technical topics
- [ ] Prepare 5 STAR stories

### Day 3-4: Technical Deep Dive
- [ ] Practice coding problems (2-3 per day)
- [ ] Review system design fundamentals
- [ ] Study specific technologies from job posting

### Day 5: Behavioral Prep
- [ ] Practice STAR stories out loud
- [ ] Record yourself answering common questions
- [ ] Refine your elevator pitch

### Day 6: Mock Interview
- [ ] Do a mock technical interview
- [ ] Practice behavioral questions with timer
- [ ] Review weak areas

### Day 7: Final Review
- [ ] Light review of notes
- [ ] Prepare logistics (outfit, tech setup)
- [ ] Get good sleep

---

## 7. Interview Day Checklist

### Before
- [ ] Review company research notes
- [ ] Have STAR stories fresh in mind
- [ ] Test video/audio setup
- [ ] Have water and notepad ready
- [ ] Know interviewer names and roles

### During
- [ ] Listen carefully to questions
- [ ] Ask clarifying questions if needed
- [ ] Use STAR structure for behavioral
- [ ] Think out loud for technical
- [ ] Take notes on interesting points

### After
- [ ] Send thank you emails within 24 hours
- [ ] Note questions you struggled with
- [ ] Reflect on what went well

---

### Step 3: Save and Convert

1. Save to: `~/job-applications/[COMPANY_NAME]/INTERVIEW_PACKAGE.md`

2. Convert to PDF:
   ```bash
   pandoc ~/job-applications/[COMPANY_NAME]/INTERVIEW_PACKAGE.md \
     -o ~/job-applications/[COMPANY_NAME]/INTERVIEW_PACKAGE.pdf \
     --pdf-engine=wkhtmltopdf \
     -V geometry:margin=0.75in \
     -V fontsize=10pt \
     --toc
   ```

### Step 4: Save to HubSpot

Create a note on the deal using `hubspot-create-engagement`:

```json
{
  "type": "NOTE",
  "ownerId": [from hubspot-get-user-details],
  "associations": {
    "dealIds": [DEAL_ID]
  },
  "metadata": {
    "body": "<h2>🎯 Interview Package</h2>[Full INTERVIEW_PACKAGE.md content as HTML]"
  }
}
```

**Note:** Convert markdown to HTML for better rendering in HubSpot.

### Step 5: Output Summary

```
## Interview Package Generated

**Position:** [Job Title] at [Company]

**Files Created:**
- ~/job-applications/[company]/INTERVIEW_PACKAGE.md
- ~/job-applications/[company]/INTERVIEW_PACKAGE.pdf

**Package Contents:**
1. Company Research
2. Technical Preparation (X topics)
3. Behavioral STAR Stories (X stories)
4. Storytelling Guide
5. Questions to Ask (X questions)
6. 1-Week Prep Schedule
7. Interview Day Checklist

**Application Package Complete:**
- [x] RESUME.pdf
- [x] COVER_LETTER.pdf
- [x] INTERVIEW_PACKAGE.pdf

**Next Steps:**
1. Review and personalize STAR stories
2. Follow the 1-week schedule
3. Run `/linkedin` to optimize your profile
```

### Important Constraints

1. **NEVER FABRICATE** - All STAR stories must be from real experience or user-confirmed
2. **Personalize** - Ask questions to surface unique stories and experiences
3. **Be practical** - Focus on preparation that matters for THIS specific role
4. **Be honest about gaps** - Help user prepare responses for potential concerns
