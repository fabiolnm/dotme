# ATS Algorithm Calibration

Compare `/ats` scoring against Jobscan benchmark. If discrepant, edit `/ats` command to improve algorithm accuracy.

## Usage
```
/prep-for-job/ats-calibrate @resume.md @jobscan-report.pdf
```

## Input
$ARGUMENTS

## Instructions

You are calibrating the `/ats` scoring algorithm against Jobscan ground truth.

**CRITICAL:** This tool updates the ALGORITHM, not the resume. Output is recommendations for editing `/ats` command rules.

### Step 1: Parse Inputs

**Required arguments:**
- Resume file (markdown)
- Jobscan report (PDF)

If arguments missing, ask user to provide both files.

### Step 2: Parse Jobscan Report

Extract ground truth from Jobscan PDF:

| Data Point | Extract |
|------------|---------|
| Overall Score | 0-100 |
| Hard Skills | Issue count + keyword match table |
| Soft Skills | Issue count + keyword match table |
| Searchability | Issue count + check statuses |
| Recruiter Tips | Issue count + check statuses |

**Extract keyword-level detail:**
- Which exact keywords Jobscan extracted from the JD
- Which keywords Jobscan marked as found vs missing
- Any synonyms Jobscan accepted

### Step 3: Run `/ats` Algorithm

Score the same resume using current `/ats` command logic:
- Extract keywords from JD (same JD Jobscan used)
- Count matches using current rules
- Calculate scores per category
- Generate issue counts

### Step 4: Compare Scores

```markdown
# Calibration Comparison

| Metric | Claude | Jobscan | Delta |
|--------|--------|---------|-------|
| Overall | XX | XX | ±X |
| Hard Skills Score | XX | XX | ±X |
| Hard Skills Issues | X | X | ±X |
| Soft Skills Score | XX | XX | ±X |
| Soft Skills Issues | X | X | ±X |
| Searchability Score | XX | XX | ±X |
| Searchability Issues | X | X | ±X |
| Recruiter Tips Score | XX | XX | ±X |
| Recruiter Tips Issues | X | X | ±X |
```

**Tolerance:** ±5 points overall, ±1 issue per category

### Step 5: Identify Algorithm Gaps

If delta exceeds tolerance, identify root causes:

**Keyword Extraction Gaps:**
| Keyword | Claude Extracted | Jobscan Extracted | Gap |
|---------|------------------|-------------------|-----|
| product development | No | Yes | Under-extraction |
| user experience | No | Yes | Under-extraction |
| TypeScript | Yes | Yes | Match |

**Keyword Matching Gaps:**
| Keyword | Claude Match | Jobscan Match | Gap Type |
|---------|--------------|---------------|----------|
| communication | ✓ | ✗ | False positive - Jobscan wants "communication skills" |
| GCP | ✓ | ✗ | False positive - Jobscan wants "Google Cloud Platform" |

**Searchability Gaps:**
| Check | Claude | Jobscan | Gap Type |
|-------|--------|---------|----------|
| Date format | ✓ | ✗ | False positive - Jobscan wants abbreviated months |
| Education header | ✓ | ✗ | False positive - non-standard header |

**Gap Types:**
- **False positive:** Claude passed it, Jobscan failed it → tighten rule
- **False negative:** Claude failed it, Jobscan passed it → loosen rule
- **Under-extraction:** Claude didn't extract keyword from JD → add to extraction rules
- **Over-extraction:** Claude extracted keyword not in Jobscan's list → remove from extraction
- **Match:** Both agree → no action

### Step 6: Generate Algorithm Updates

Output specific edits needed for `/ats` command file:

```markdown
## Recommended /ats Algorithm Updates

### 1. Keyword Extraction Rules

**Add to hard skills extraction:**
- Domain terms like "product development", "user experience", "user needs"
- Work practices like "pair programming", "whiteboarding"

**Current rule:**
> Parse for technical terms: Programming languages, frameworks, databases

**Updated rule:**
> Parse ALL skill-related terms from JD including:
> - Programming languages, frameworks, databases
> - Domain terms: "product development", "user experience", "user needs"
> - Work practices: "pair programming", "code review"

### 2. Matching Rules

**Tighten phrase matching:**
- "communication" should NOT match "communication skills"
- "GCP" should NOT match "Google Cloud Platform"

**Add to NOT synonyms list:**
```
- "communication" ≠ "communication skills"
- "GCP" ≠ "Google Cloud Platform"
```

### 3. Searchability Rules

**Tighten date format check:**
- Current: Any consistent date format = PASS
- Updated: Abbreviated months required (Dec not December)

**Tighten section header check:**
- Current: Any education-related header = PASS
- Updated: Exact "Education" header required
```

### Step 7: Apply Updates to /ats

Edit `/Users/fabio/.me/claude/commands/prep-for-job/ats.md` with the identified changes.

Show diff of changes made:
```diff
- Parse for technical terms:
+ Parse ALL skill-related terms from JD including:
+   - Domain terms: "product development", "user experience"
```

### Step 8: Verify Calibration

After editing `/ats`:
1. Re-score the resume with updated algorithm
2. Compare new score to Jobscan benchmark
3. Report improvement

```markdown
# Calibration Result

## Before Algorithm Update
| Metric | Claude | Jobscan | Delta |
|--------|--------|---------|-------|
| Overall | 88 | 64 | +24 |

## After Algorithm Update
| Metric | Claude | Jobscan | Delta |
|--------|--------|---------|-------|
| Overall | 66 | 64 | +2 |

**Accuracy improved:** Delta reduced from ±24 to ±2

## Changes Made to /ats
1. Added domain terms to keyword extraction
2. Tightened phrase matching (communication ≠ communication skills)
3. Required abbreviated month format
4. Required exact "Education" section header
```

### Step 9: Output Summary

```
## Calibration Complete

**Accuracy:** ±X points (target: ±5)
**Algorithm changes:** X edits made to /ats

[If within tolerance]
✓ Algorithm calibrated. /ats scoring now matches Jobscan.

[If still outside tolerance]
⚠ Some discrepancies remain. Likely causes:
- Jobscan uses proprietary keyword weighting
- Different JD parsing heuristics
Consider additional benchmarks for further calibration.
```

### Important Notes

1. **Never edit the resume** - this tool only updates the scoring algorithm
2. **Document all changes** - future calibrations build on previous ones
3. **One benchmark at a time** - calibrate against one Jobscan report, verify, then try another
4. **Diminishing returns** - ±5 points is acceptable; perfect match unlikely due to proprietary Jobscan logic
