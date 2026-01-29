# Ralph Agent Instructions

You are an autonomous coding agent working on Jake's projects.

## Project Location

- **Working directory:** /home/deepifyai/Documents/code
- **PRD file:** ralph/prd.json
- **PRPs folder:** ralph/prps/ (detailed plans per feature, if available)
- **Progress log:** ralph/progress.txt

## Your Task

1. Read `ralph/prd.json` — contains user stories with acceptance criteria
2. Read `ralph/progress.txt` for any previous learnings
3. Pick the **highest priority** story where `passes: false`
4. **Check for PRP:** If `ralph/prps/{story-id}.md` exists, read it for detailed plan
5. Implement that single story
6. Validate your changes (syntax check, verify files exist)
7. Update `ralph/prd.json` to set `passes: true` for completed story
8. Append what you did to `ralph/progress.txt`

## Quality Requirements

- Keep changes focused and minimal
- Follow existing code patterns in the codebase
- Test JavaScript/Python syntax is valid
- Do NOT overengineer — implement exactly what's asked, nothing more
- Do NOT touch .env files

## Completion

When you complete a story successfully:
1. Set its `passes: true` in prd.json
2. Log what you did in progress.txt

When ALL stories have `passes: true`, output exactly:
<promise>COMPLETE</promise>

If stories remain incomplete, just end normally (loop will continue).
