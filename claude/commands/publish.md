# Publish Garden

Commit and push pending garden changes to trigger deployment.

## Instructions

1. Run `git -C ~/garden status` to check for changes
2. If no changes, inform user and stop
3. If changes exist, open `~/garden` in Obsidian for review and wait for user confirmation
4. After user confirms, commit with descriptive message based on changed files
5. Push to main
6. Confirm push succeeded and link to GitHub Actions
