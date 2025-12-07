# Publish Journal to Web

Deploy the blog to fabioluiz.dev via GitHub Pages.

## Instructions

1. Change to the blog directory: `cd ~/blog`
2. Check git status for changes
3. Stage all changes: `git add .`
4. Commit with message: `git commit -m "Publish: $(date +%Y-%m-%d)"`
5. Push to main: `git push origin main`

GitHub Actions will automatically:
- Build the Quartz static site
- Deploy to GitHub Pages
- Update fabioluiz.dev

## Pre-flight Checks

Before publishing, verify:
- [ ] No entries with `draft: true` that should not be published
- [ ] All wikilinks resolve to existing pages
- [ ] Images are in `static/images/`

## After Publishing

The site typically updates within 2-3 minutes. Check:
- https://fabioluiz.dev
- GitHub Actions tab for build status
