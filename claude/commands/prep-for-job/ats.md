# ATS Resume Score Analysis

Score your resume against ATS (Applicant Tracking System) criteria and job requirements.

## Usage
```
/prep-for-job/ats
/prep-for-job/ats @jobrank-report.pdf
```

## Input
$ARGUMENTS

## Instructions

You are an ATS optimization expert. Analyze the resume against the job description and provide actionable feedback.

### Step 1: Gather Inputs

**Resume:**
- Read `~/job-applications/[COMPANY_NAME]/RESUME.md`
- If multiple companies exist, ask which one to analyze

**Job Description:**
- Search HubSpot for the matching deal
- Read the job description from deal notes or `original_message`

**Benchmark File (Optional):**
- Ask: "Do you have a benchmark report from jobrank.ca or similar ATS scoring tool? This helps calibrate scoring accuracy."
- If provided as argument or user provides path, read and parse the benchmark
- Use benchmark scores as reference points for calibration

### Step 2: ATS Scoring Criteria (0-10 scale)

Score each category and calculate weighted average:

| Category | Weight | Criteria |
|----------|--------|----------|
| **Keyword Match** | 30% | Job description terms found in resume |
| **Skills Alignment** | 25% | Required skills present and prominent |
| **Format Parseability** | 15% | Standard sections, no complex formatting |
| **Section Completeness** | 15% | All required sections present |
| **Quantified Achievements** | 15% | Metrics, numbers, percentages in bullets |

#### 2.1 Keyword Match (0-10)
- Extract key terms from job description
- Count exact and semantic matches in resume
- Score: (matches / total keywords) * 10

#### 2.2 Skills Alignment (0-10)
- List required skills from job posting
- Check presence in Technical Skills section
- Check usage in experience bullets
- Penalize missing critical skills

#### 2.3 Format Parseability (0-10)
- Standard headers: +2
- No tables/columns: +2
- Clear hierarchy: +2
- Consistent formatting: +2
- Standard date formats: +2

#### 2.4 Section Completeness (0-10)
- Contact info: +2
- Summary: +2
- Skills: +2
- Experience: +2
- Education: +2

#### 2.5 Quantified Achievements (0-10)
- Count bullets with metrics
- Score: (quantified bullets / total bullets) * 10

### Step 3: Compare with Benchmark (if provided)

If benchmark file provided:
1. Parse the external tool's scores
2. Compare category-by-category
3. Note discrepancies > 1 point
4. Adjust recommendations based on external feedback
5. Include calibration notes in output

### Step 4: Generate Analysis

Create detailed analysis with:

```markdown
# ATS Score Analysis

**Resume:** [Company Name] - [Job Title]
**Analysis Date:** [Date]
**Benchmark Used:** [Yes/No - Tool Name]

## Overall Score: [X.X]/10

| Category | Score | Weight | Weighted |
|----------|-------|--------|----------|
| Keyword Match | X.X | 30% | X.XX |
| Skills Alignment | X.X | 25% | X.XX |
| Format Parseability | X.X | 15% | X.XX |
| Section Completeness | X.X | 15% | X.XX |
| Quantified Achievements | X.X | 15% | X.XX |

## Keyword Analysis

### Found Keywords (X/Y)
- [keyword]: Found in [section]
- ...

### Missing Keywords (Critical)
- [keyword]: Suggested placement: [section]
- ...

## Skills Gap Analysis

### Required Skills Present
- [skill]: [location in resume]

### Required Skills Missing
- [skill]: Consider adding if you have experience

## Improvement Recommendations

### Priority 1 (Quick Wins)
1. [Specific actionable change]
2. [Specific actionable change]

### Priority 2 (Significant Impact)
1. [Specific actionable change]
2. [Specific actionable change]

### Priority 3 (Nice to Have)
1. [Specific actionable change]

## Benchmark Comparison (if applicable)

| Category | Claude Score | Benchmark Score | Delta |
|----------|--------------|-----------------|-------|
| ... | ... | ... | ... |

**Calibration Notes:** [observations about scoring differences]

```

### Step 5: Save Output

Save to: `~/job-applications/[COMPANY_NAME]/ATS_SCORE_ANALYSIS.md`

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
    "body": "<h2>📈 ATS Score: [X.X]/10</h2>[Full ATS_SCORE_ANALYSIS.md content as HTML]"
  }
}
```

**Note:** Convert markdown to HTML. Include score in title for quick reference.

### Step 7: Provide Guidance

**If score < 8.5:**
```
## Action Required

Your ATS score is [X.X]/10. Target is 8.5+.

Top 3 improvements to make:
1. [Most impactful change]
2. [Second most impactful]
3. [Third most impactful]

After making changes, run `/prep-for-job/ats` again to re-score.
```

**If score >= 8.5:**
```
## Ready to Proceed

Your ATS score is [X.X]/10. This meets the 8.5+ threshold.

Your resume is optimized for ATS parsing.
```

### Important Notes

1. **Be specific** - Don't say "add more keywords", say "add 'PostgreSQL' to Technical Skills"
2. **Prioritize** - Not all changes are equal; focus on high-impact items
3. **Be honest** - If the resume needs significant work, say so clearly
4. **Use benchmark** - If provided, trust external tool for calibration insights
