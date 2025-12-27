# ATS Algorithm Calibration

Compare `/ats` scoring against Jobscan benchmark. If discrepant, edit `/ats` command to improve accuracy.

## Usage
```
/prep-for-job/ats-calibrate @resume.md @jobscan-report.pdf
```

## Input
$ARGUMENTS

## Instructions

You are calibrating the `/ats` scoring algorithm against Jobscan ground truth.

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
| Hard Skills | Issue count + keyword table |
| Soft Skills | Issue count + keyword table |
| Searchability | Issue count + check statuses |
| Recruiter Tips | Issue count + check statuses |

### Step 3: Run `/ats` Algorithm

Score the same resume using current `/ats` command logic:
- Extract keywords from JD
- Count matches
- Calculate scores per category
- Generate issue counts

### Step 4: Compare Scores

```markdown
# Calibration Comparison

| Metric | Claude | Jobscan | Delta |
|--------|--------|---------|-------|
| Overall | XX | XX | ±X |
| Hard Skills Issues | X | X | ±X |
| Soft Skills Issues | X | X | ±X |
| Searchability Issues | X | X | ±X |
| Recruiter Tips Issues | X | X | ±X |
```

**Tolerance:** ±5 points overall, ±1 issue per category

### Step 5: Identify Algorithm Gaps

If delta exceeds tolerance, identify root causes:

**Keyword Detection Gaps:**
| Keyword | Claude | Jobscan | Gap Type |
|---------|--------|---------|----------|
| query tuning | ✗ | ✗ | Match |
| product development | ✓ | ✗ | False positive |
| memcached | ✗ | ✗ | Match |

**Searchability Gaps:**
| Check | Claude | Jobscan | Gap Type |
|-------|--------|---------|----------|
| Address | ✓ | ✗ | False positive |

**Gap Types:**
- **False positive:** Claude found it, Jobscan didn't → tighten matching
- **False negative:** Claude missed it, Jobscan found it → add synonym/pattern
- **Match:** Both agree → no action

### Step 6: Edit `/ats` Command

If significant gaps found, edit `/Users/fabio/.claude/commands/prep-for-job/ats.md`:

**Synonym Map Updates:**
```markdown
### Jobscan Keyword Synonym Map

Common synonyms to treat as matches:
- PostgreSQL = Postgres
- query tuning = query optimization = optimized queries  ← ADD
- product development = product engineering             ← ADD
```

**Scoring Rule Updates:**
- Adjust searchability checks to match Jobscan's criteria
- Update soft skill detection patterns
- Modify point allocations if category weights are off

### Step 7: Re-run `/ats` and Verify

After editing `/ats` command:
1. Re-score the resume with updated algorithm
2. Compare new score to Jobscan benchmark
3. Report improvement

```markdown
# Calibration Result

## Before
| Metric | Claude | Jobscan | Delta |
|--------|--------|---------|-------|
| Overall | 72 | 65 | +7 |

## After Algorithm Update
| Metric | Claude | Jobscan | Delta |
|--------|--------|---------|-------|
| Overall | 66 | 65 | +1 |

**Accuracy improved:** Delta reduced from ±7 to ±1

## Changes Made to /ats
1. Added synonym: "query tuning" = "query optimization"
2. Tightened address check: requires "City, Province/State"
3. [Other changes]
```

### Step 8: Output Summary

```
Calibration complete.

Accuracy: ±X points (target: ±5)
Algorithm changes: X edits made to /ats

[If within tolerance]
✓ Algorithm calibrated. Run /ats to score resumes.

[If still outside tolerance]
⚠ Some discrepancies remain. Consider additional Jobscan benchmarks for further calibration.
```
