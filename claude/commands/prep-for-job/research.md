# Company Research

Research a company thoroughly to support job application materials.

## Usage
```
/prep-for-job/research
/prep-for-job/research [COMPANY_NAME]
```

## Input
$ARGUMENTS

## Instructions

You are a company research analyst. Gather comprehensive information to support job applications.

### Step 1: Identify Target Company

- If company name provided as argument, use it
- Otherwise, read most recent deal from HubSpot to get company name
- Confirm: "Researching [COMPANY_NAME]. Correct?"

### Step 2: Launch Parallel Research

Execute these searches simultaneously using parallel subagents:

| Source | What to Find |
|--------|--------------|
| **Company website** | Mission, values, products, about page, careers page |
| **Engineering blog** | Tech stack, architecture decisions, engineering culture |
| **YouTube** | Company channel, conference talks, product demos, culture videos |
| **Glassdoor** | Overall rating, interview process, culture reviews, pros/cons |
| **LinkedIn** | Company page, recent posts, employee count, growth |
| **News** | Recent funding, acquisitions, product launches, press releases |
| **Crunchbase** | Funding history, investors, company stage |
| **GitHub** | Open source projects, tech stack indicators |

### Step 3: Compile Findings

Create structured research document:

```markdown
# Company Research: [COMPANY_NAME]

**Research Date:** [Date]
**Position:** [Job Title from HubSpot deal]

---

## Company Overview

- **Founded:** [Year]
- **Headquarters:** [Location]
- **Size:** [Employee count]
- **Stage:** [Startup/Growth/Enterprise]
- **Industry:** [Industry]

## Mission & Values

[Mission statement]

**Core Values:**
- [Value 1]
- [Value 2]

---

## Products & Services

- **Main Product:** [Description]
- **Target Market:** [Who they serve]
- **Competitors:** [Key competitors]

---

## Technology & Engineering

**Known Tech Stack:**
- Backend: [Technologies]
- Frontend: [Technologies]
- Infrastructure: [Technologies]

**Engineering Culture:**
- [Insight from blog/talks]
- [Insight from Glassdoor]

**Open Source:**
- [Notable projects if any]

---

## Recent News & Developments

| Date | Headline | Source |
|------|----------|--------|
| [Date] | [Headline] | [Link] |

---

## Glassdoor Insights

- **Rating:** [X.X/5] ([N] reviews)
- **Interview Difficulty:** [X.X/5]
- **Recommend to Friend:** [X%]

**Interview Process:**
- [Stage 1]
- [Stage 2]
- [Common questions]

**Pros (themes):**
- [Theme 1]
- [Theme 2]

**Cons (themes):**
- [Theme 1]
- [Theme 2]

---

## Key People

| Name | Role | Notes |
|------|------|-------|
| [Name] | [Title] | [Relevant info] |

---

## Why This Matters for Your Application

**Alignment Points:**
- [Your experience X aligns with their focus on Y]
- [Your skill Z matches their tech stack]

**Talking Points for Cover Letter:**
- [Specific thing to mention]
- [Recent news to reference]

**Interview Prep Notes:**
- [Culture aspect to emphasize]
- [Question to ask based on research]

---

## Sources

- [URL 1]
- [URL 2]
```

### Step 4: Present Findings Summary

```
## Company Research Complete: [COMPANY]

**Found:**
- [x] Website: [brief insight]
- [x] Engineering blog: [X] articles reviewed
- [x] YouTube: [X] videos found
- [x] Glassdoor: [X.X] rating, [N] reviews
- [x] News: [X] recent articles
- [x] LinkedIn: [employee count], [growth trend]
- [ ] GitHub: [found/not found]

**Key Insights:**
1. [Most important finding]
2. [Second most important]
3. [Third most important]

**Gaps - Could Not Find:**
- [Missing info 1]
- [Missing info 2]
```

### Step 5: Ask for Additional Materials

"I've compiled the research above. Would you like to add any materials I couldn't find?

- Internal docs or strategy decks?
- Specific blog posts or videos you've seen?
- Notes from conversations with employees or recruiters?
- Investor presentations or earnings calls?
- Other insider knowledge?"

If user provides additional materials, incorporate into the research document.

### Step 6: Save Output

Save to: `~/job-applications/[COMPANY_NAME]/COMPANY_RESEARCH.md`

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
    "body": "<h2>📋 Company Research</h2>[Full COMPANY_RESEARCH.md content as HTML]"
  }
}
```

**Note:** Convert markdown to HTML for better rendering in HubSpot. Include the full document content.

### Step 8: Output Summary

```
## Research Saved

**Company:** [COMPANY_NAME]
**File:** ~/job-applications/[company]/COMPANY_RESEARCH.md

**Ready for:**
- `/prep-for-job/fit` - Job fit scoring
- `/prep-for-job/cover-letter` - Personalized cover letter
- `/prep-for-job/interview` - Interview preparation

**Next Step:** Run `/prep-for-job/fit @linkedin.pdf` to calculate job fit score
```

### Important Notes

1. **Be thorough** - This research powers multiple downstream steps
2. **Cite sources** - Include URLs for verification
3. **Focus on relevance** - Prioritize info useful for the application
4. **Note gaps** - Explicitly call out what couldn't be found
5. **Stay current** - Prioritize recent information (last 12 months)
