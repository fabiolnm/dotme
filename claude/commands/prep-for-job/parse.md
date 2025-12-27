# Add Job to Pipeline

Parse a job opportunity and add it to the HubSpot Job Search Pipeline with full record creation.

## Usage
```
/prep-for-job/parse JOB_DESCRIPTION
```

## Input
$ARGUMENTS

## Instructions

You are a job opportunity parser. Parse the job description and create a complete record set in HubSpot.

### Step 1: Extract Information

Parse the input to extract:

1. **Source** - Determine based on HOW the opportunity came to you:
   - `recruiter` - An external recruiting agency/staffing firm reached out (via any channel: LinkedIn DM, email, etc.)
   - `direct` - Someone from the actual hiring company reached out directly
   - `referral` - A friend/colleague referred you
   - `linkedin` - You found a job posting on LinkedIn and applied yourself
   - `job_board` - You found the job on Indeed, Glassdoor, etc.
   - `company_website` - You found the job on the company's careers page
   - `email` - Job listing received via email newsletter/alert
   - `other` - Anything else

   **Key distinction:** If a recruiter from an agency (e.g., "Quantum Technology Recruiting") contacts you about a role at another company (e.g., "Instacart"), the source is `recruiter`, NOT the platform they used to contact you.

2. **Job Title** - The position title
3. **Hiring Company** - The company that is hiring (not the recruiting agency)
4. **Recruiter Name** - Name of the recruiter/contact person (first and last)
5. **Recruiter Email** - Email address if provided
6. **Recruiter Company** - If using external recruiter, their company name
7. **Job Location** - Geographic location (city, state, country)
8. **Work Mode** - remote, onsite, or hybrid
9. **Work Mode Details** - Specific arrangement (e.g., "3 days office/2 days remote")
10. **Contract Type** - fte, contract, contract_to_hire, part_time, freelance
11. **Contract Duration** - For contracts, the duration (e.g., "6 months", "1 year")
12. **Job Type** - Employment classification: w2, 1099, c2c, unknown (if not specified)
13. **Priority** - How interested you are: high, medium, low (default: medium)
14. **Seniority Level** - junior, intermediate, senior, staff, principal, lead, manager, director
15. **Tech Stack** - Map to available tags (semicolon-separated): react, typescript, javascript, python, ruby, rails, nodejs, go, rust, java, kotlin, swift, csharp, dotnet, php, graphql, rest, grpc, postgresql, mysql, mongodb, redis, elasticsearch, kafka, aws, gcp, azure, docker, kubernetes, terraform, react_native, vuejs, angular, nextjs, django, fastapi, spring, snowflake, dbt, looker, datadog, cicd, css

   **Adding New Tech Stack Tags:** If the job requires a technology not in this list:
   1. Use `hubspot-get-property` to fetch current `tech_stack` options for deals
   2. Use `hubspot-update-property` to add the new option (include ALL existing options plus the new one, maintaining alphabetical order by value)
   3. Then proceed with creating the deal using the new tag
16. **Compensation Min** - Lower bound of yearly range in CAD (hourly rate × 2080 for full-time)
17. **Compensation Max** - Upper bound of yearly range in CAD
18. **Compensation Details** - Raw compensation info, hourly rates, bonuses, equity mentions
19. **Description** - Brief summary of the role and responsibilities
20. **Last Activity Date** - Date of the most recent interaction (today if new outreach)

### Step 2: Determine Pipeline Stage

Based on the context of the message, determine the appropriate stage:

| Stage ID | Label | When to Use |
|----------|-------|-------------|
| `2630040252` | New Opportunity | Recruiter reached out, or you found a posting. Includes initial back-and-forth to schedule calls. (DEFAULT) |
| `2630032098` | Responded/Applied | You've formally applied OR submitted resume/materials to the company |
| `2630040287` | Resume Sent | Resume has been sent to the company |
| `2630040259` | Interview Prep | Preparing for upcoming interviews |
| `2630040260` | Recruiter Screen | Initial call with recruiter/HR scheduled or completed |
| `2630032099` | Technical Screen | Phone/video technical interview |
| `2630040267` | On-site/Final Round | Final interview rounds |
| `2630040268` | Offer Received | Got an offer |
| `2630032100` | Negotiating | In salary/terms negotiation |
| `closedwon` | Accepted | Accepted the offer |
| `closedlost` | Rejected/Declined | Rejected or you declined |

**Default to `2630040252` (New Opportunity)** for initial recruiter outreach or job postings.

### Step 3: Research Compensation (REQUIRED)

**Always populate compensation fields.** If not provided in the job description:

1. Web search for: `[Company Name] [Job Title] salary levels.fyi 2024`
2. Web search for: `[Company Name] [Job Title] salary glassdoor 2024`
3. Web search for: `[Job Title] [Location] contract rate 2024` (for contract roles)

Set:
- `compensation_min` - Lower bound of yearly salary in CAD
- `compensation_max` - Upper bound of yearly salary in CAD
- `compensation_details` - Include:
  - Source of estimate (e.g., "Estimated from levels.fyi" or raw info if provided)
  - Level breakdown if available (L3-L7 or equivalent company levels with salary bands)
  - Hourly rate if contract role
  - If compensation is provided in USD, convert to CAD (use current exchange rate ~1.44)

For hourly contract rates, convert to annual: hourly × 2080 = yearly equivalent.
For USD amounts, convert to CAD before storing.

### Step 4: Search for Existing Records

Before creating new records, search HubSpot for existing:

1. **Search for Hiring Company** by name using `hubspot-search-objects` with objectType `companies`
2. **Search for Recruiter Company** (if different) by name
3. **Search for Recruiter Contact** by email using `hubspot-search-objects` with objectType `contacts`

### Step 5: Create Missing Records

Use `hubspot-batch-create-objects` to create any missing records:

#### 5a. Create Companies (if not found)

**Hiring Company:**
```json
{
  "objectType": "companies",
  "inputs": [{
    "properties": {
      "name": "[Hiring Company Name]",
      "description": "Hiring company for job opportunity"
    }
  }]
}
```

**Recruiter Company** (if external recruiter and company not found):
```json
{
  "objectType": "companies",
  "inputs": [{
    "properties": {
      "name": "[Recruiter Company Name]",
      "description": "Recruiting agency"
    }
  }]
}
```

#### 5b. Create Contact (if recruiter email provided and not found)

```json
{
  "objectType": "contacts",
  "inputs": [{
    "properties": {
      "firstname": "[First Name]",
      "lastname": "[Last Name]",
      "email": "[Email]",
      "company": "[Recruiter Company or Hiring Company]",
      "jobtitle": "[Title if known, e.g., 'Recruiter', 'Group Manager']"
    }
  }]
}
```

### Step 6: Create the Deal

Use `hubspot-batch-create-objects` to create the deal:

```json
{
  "objectType": "deals",
  "inputs": [{
    "properties": {
      "dealname": "[Hiring Company] - [Job Title]",
      "pipeline": "default",
      "dealstage": "[stage ID from table above]",
      "description": "[brief role summary]",
      "job_title": "[title]",
      "hiring_company": "[company]",
      "job_source": "[source]",
      "job_location": "[location]",
      "work_mode": "[remote/onsite/hybrid]",
      "work_mode_details": "[details]",
      "contract_type": "[type]",
      "contract_duration": "[duration if contract]",
      "seniority_level": "[level]",
      "dealtype": "[w2/1099/c2c/unknown]",
      "hs_priority": "[high/medium/low]",
      "tech_stack": "[semicolon-separated tags]",
      "compensation_min": "[lower bound as number]",
      "compensation_max": "[upper bound as number]",
      "compensation_details": "[raw comp info]",
      "recruiter_name": "[name]",
      "recruiter_email": "[email]",
      "recruiter_company": "[agency name]",
      "last_activity_date": "[YYYY-MM-DD format]",
      "original_message": "[full original input - truncated to 65000 chars max]"
    }
  }]
}
```

### Step 7: Create Associations

Use `hubspot-batch-create-associations` to link records:

#### 7a. Deal → Hiring Company (Primary)
```json
{
  "fromObjectType": "deals",
  "toObjectType": "companies",
  "types": [{"associationCategory": "HUBSPOT_DEFINED", "associationTypeId": 5}],
  "inputs": [{"from": {"id": "[DEAL_ID]"}, "to": {"id": "[HIRING_COMPANY_ID]"}}]
}
```

#### 7b. Deal → Recruiter Contact
```json
{
  "fromObjectType": "deals",
  "toObjectType": "contacts",
  "types": [{"associationCategory": "HUBSPOT_DEFINED", "associationTypeId": 3}],
  "inputs": [{"from": {"id": "[DEAL_ID]"}, "to": {"id": "[CONTACT_ID]"}}]
}
```

#### 7c. Contact → Recruiter Company (Primary)
```json
{
  "fromObjectType": "contacts",
  "toObjectType": "companies",
  "types": [{"associationCategory": "HUBSPOT_DEFINED", "associationTypeId": 1}],
  "inputs": [{"from": {"id": "[CONTACT_ID]"}, "to": {"id": "[RECRUITER_COMPANY_ID]"}}]
}
```

### Step 8: Log Activities

Use `hubspot-create-engagement` to log activities in the HubSpot timeline.

#### 8a. Always Create Job Description Note

Always create a note with the full job description so it's visible in the deal timeline:

```json
{
  "type": "NOTE",
  "ownerId": 78542821,
  "associations": {
    "dealIds": [DEAL_ID]
  },
  "metadata": {
    "body": "<strong>Job Description</strong><br><br>[Full job description with <br> for line breaks]"
  }
}
```

#### 8b. Log Conversation Messages (if present)

If the input contains conversation messages (recruiter outreach, back-and-forth DMs), create additional notes for each message:

**Inbound message (from recruiter/company):**
```json
{
  "type": "NOTE",
  "ownerId": 78542821,
  "associations": {
    "dealIds": [DEAL_ID],
    "contactIds": [CONTACT_ID]
  },
  "metadata": {
    "body": "<strong>Inbound from [Name] ([Channel]) - [Date Time]</strong><br><br>[Message content with <br> for line breaks]"
  }
}
```

**Outbound message (your response):**
```json
{
  "type": "NOTE",
  "ownerId": 78542821,
  "associations": {
    "dealIds": [DEAL_ID],
    "contactIds": [CONTACT_ID]
  },
  "metadata": {
    "body": "<strong>My Response ([Channel]) - [Date Time]</strong><br><br>[Message content with <br> for line breaks]"
  }
}
```

Create separate notes for each distinct message in chronological order. Include:
- Sender (their name for inbound, "My Response" for outbound)
- Channel (LinkedIn DM, Email, etc.)
- Date and time if available
- Full message content

### Step 9: Output Summary

After creating all records, output a formatted summary:

```
## Job Added to Pipeline

**[Job Title]** at **[Hiring Company]**

| Field | Value |
|-------|-------|
| Stage | [Stage Name] |
| Source | [Source] |
| Location | [Location] |
| Work Mode | [Mode] |
| Contract | [Type] |
| Job Type | [W2/1099/C2C/Unknown] |
| Seniority | [Level] |
| Priority | [High/Medium/Low] |
| Compensation | $[Min] - $[Max] CAD or "Not specified" |
| Last Activity | [Date] |

**Tech Stack:** [technologies]

**Recruiter:** [Name] ([Email]) - [Company]

### Records Created/Linked
- **Deal:** [HubSpot Deal Link](https://app-na2.hubspot.com/contacts/242288945/record/0-3/[DEAL_ID])
- **Hiring Company:** [Company Link](https://app-na2.hubspot.com/contacts/242288945/record/0-2/[COMPANY_ID])
- **Recruiter:** [Contact Link](https://app-na2.hubspot.com/contacts/242288945/record/0-1/[CONTACT_ID])
- **Recruiter Agency:** [Company Link](https://app-na2.hubspot.com/contacts/242288945/record/0-2/[AGENCY_ID]) (if applicable)

### Activities Logged
- [1] job description note
- [X] inbound messages (if any)
- [X] outbound messages (if any)
```

### Important Notes

- **Last Contacted** (`notes_last_contacted`) is auto-set by HubSpot when calls/emails/meetings are logged - we track `last_activity_date` separately for manual updates
- If information is not available, omit that property (don't set empty strings)
- **Compensation fields are REQUIRED** - always research and populate min/max/details
- The pipeline ID is `default`
- Always store the original message for reference
- Be conservative with stage assignment - default to `2630040252` (New Opportunity) if unclear
- Always search for existing records before creating duplicates
- Set `last_activity_date` to the date of the most recent message/interaction in the input
