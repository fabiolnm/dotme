# Generate ATS-Optimized Resume

Generate an ATS-optimized resume tailored to a specific job opportunity.

## Usage
```
/prep-for-job/resume @linkedin-export.pdf
```

## Input
$ARGUMENTS

## Instructions

You are an expert resume writer specializing in ATS optimization for software engineering roles.

### Step 1: Gather Inputs

**LinkedIn Profile:**
- If a LinkedIn PDF export is provided as argument, read it
- If not provided, prompt: "Please provide your current LinkedIn PDF export (File > Save as PDF)"
- Extract: contact info, work history, skills, education, achievements

**Active Job:**
- Already available in context from orchestrator (parsed in Step 1)
- Extract: job title, company name, required skills, responsibilities, tech stack

### Step 2: Create Output Directory

Create directory: `~/job-applications/[COMPANY_NAME]/`
- Sanitize company name (lowercase, hyphens for spaces)
- Example: `~/job-applications/instacart/`

### Step 3: Generate Resume Following MANDATORY Guidelines

**CRITICAL: NEVER fabricate information. Only use data from the LinkedIn profile or ask clarifying questions.**

#### 3.1 ATS Optimization Rules
- Use standard section headers that ATS can parse
- No tables, columns, or complex formatting
- Include exact keywords from job description
- Use standard fonts (the PDF converter will handle this)

#### 3.2 Required Sections (in order)

**Header:**
```
# [FULL NAME]
**[City, Province/State, Country]**
[Phone] | [Email] | linkedin.com/in/[handle]
```

**Professional Title & Keywords:**
```
## [JOB TITLE MATCHING THE POSTING]
**[Keyword 1] | [Keyword 2] | [Keyword 3] | [Keyword 4] | [Keyword 5]**
```

**Summary (2-3 sentences):**
- Years of experience + key expertise
- Top achievement with metrics
- AI forward-looking statement: excitement to spearhead AI initiatives, integrate AI into development workflows

**Technical Skills (grouped):**
- Prioritize skills mentioned in job description FIRST
- Group by category: Languages, Frameworks, Databases, Cloud/DevOps, Testing

**AI & Development Innovation:**
- Position AFTER Technical Skills, BEFORE Professional Experience
- 2-3 bullets showcasing AI-assisted development practices
- Claude Code workflows, AI pair programming, automated code generation
- Quantify productivity gains where possible
- Ask user: "What specific AI tools or workflows have you used? What productivity gains have you seen?"

**Professional Experience (reverse chronological):**
- Company name, job title, dates, location
- 3-5 bullet points per role using STAR method:
  - Start with action verb
  - Include context (Situation/Task)
  - Describe what YOU did (Action)
  - Quantify results (Result): %, $, time, scale

**Education & Continuous Learning:**
- Degree, institution, graduation year
- Recent courses/certifications (even basic/awareness level):
  - AI/ML: Andrew Ng courses, DeepLearning.AI, fast.ai
  - Cloud: AWS, GCP, Azure certifications
  - Platforms: Udemy, Coursera, LinkedIn Learning
- Ask user: "Any recent courses or certifications? Include even introductory ones - they show continuous learning."

**Key Achievements (optional):**
- 3-4 major career highlights with metrics

#### 3.3 STAR Method Examples

Good: "Led Ruby 2.0→3.0 migration for platform serving 80,000+ organizations, implementing staged rollout with comprehensive test coverage, resulting in zero production incidents"

Bad: "Responsible for Ruby upgrades" (no STAR, no metrics)

#### 3.4 Tailoring Rules
- Match professional title exactly or closely to job posting
- Reorder skills to match job requirements order
- Emphasize relevant experience, minimize unrelated work
- Mirror language/terminology from job description

### Step 4: Ask Clarifying Questions

Before generating, ask about:
1. Any recent projects not on LinkedIn?
2. Specific AI/Claude Code achievements to highlight?
3. Metrics for key accomplishments if not in LinkedIn?
4. Any skills to emphasize or de-emphasize?

### Step 5: Generate and Save

1. Generate resume in Markdown format
2. Save to: `~/job-applications/[COMPANY_NAME]/RESUME.md`
3. Convert to PDF using pandoc:
   ```bash
   pandoc ~/job-applications/[COMPANY_NAME]/RESUME.md \
     -o ~/job-applications/[COMPANY_NAME]/RESUME.pdf \
     --pdf-engine=wkhtmltopdf \
     -V geometry:margin=0.75in \
     -V fontsize=11pt
   ```

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
    "body": "<h2>📄 Optimized Resume</h2>[Full RESUME.md content as HTML]"
  }
}
```

**Note:** Convert markdown to HTML for better rendering in HubSpot.

### Step 7: Output Summary

```
## Resume Generated

**Target:** [Job Title] at [Company]

**Output:**
- ~/job-applications/[company]/RESUME.md
- ~/job-applications/[company]/RESUME.pdf

**Keywords Matched:** [X] of [Y] from job description
```

### Important Constraints

1. **NEVER FABRICATE** - If information isn't in the LinkedIn profile, ASK the user
2. **Keep to 1-2 pages** - Be ruthless about what to include
3. **Quantify everything** - If no metric exists, ask the user
4. **Match the job** - Every bullet should relate to job requirements where possible
5. **Active voice** - "Built", "Led", "Designed" not "Was responsible for"
