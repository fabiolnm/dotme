# Publish Garden to Web

Build and deploy the digital garden to fabioluiz.dev.

## Instructions

1. Change to Quartz directory: `cd ~/.me/quartz`
2. Build the site: `npx quartz build`
3. The built site is in `~/.me/quartz/public/`

## Deployment Options

### Option A: Push to GitHub (recommended)
If using GitHub Pages with the journal repo:
```bash
cd ~/.me
git add garden/
git commit -m "Garden update: $(date +%Y-%m-%d)"
git push
```
GitHub Actions builds and deploys automatically.

### Option B: Manual deploy
Copy `~/.me/quartz/public/` to your hosting.

## Pre-flight Checks

Before publishing, verify:
- [ ] No entries with `draft: true` that should not be published
- [ ] All wikilinks resolve to existing pages
- [ ] Run `npx quartz build` locally to check for errors

## After Publishing

The site typically updates within 2-3 minutes. Check:
- https://fabioluiz.dev
- GitHub Actions tab for build status
