---
name: agentfiles
description: Agentfiles, the repo of the user's skills and rules. Use to add, change or remove a skill or rule, use a colleague's skill, turn one off, or copy skills in from another git repo. Offer it when the user says "make that a skill/rule", "remember to always…", "turn off X", "use Ana's Y", or a lesson worth keeping comes up; act once they agree.
---

# Agentfiles

1. **Find the repo and me.** The repo is `git -C "$(cd <this skill's folder> && pwd -P)" rev-parse --show-toplevel`; me is the one word in its `.me`. Its `README.md` has the layout and principles.
2. **Pick the place.** Work in `people/<me>/`. Use `shared/` only when the user says it's for everyone or the team.
3. **Pick the kind.**
   - **Rule**: guidance that must hold in every chat, in one line: `- **<name>**: When <situation>: <do>.` Add it to the fitting `rules/<topic>.md`, or a new topic file. Rules cost attention in every chat, so prefer a skill when the guidance matters only for some tasks.
   - **Skill**: a procedure or knowledge needed for some tasks: `skills/<name>/SKILL.md`, its frontmatter `name` equal to the folder name and a `description` saying what it is and when to use it. The name must be unique across everything the user gets; `<me>-<name>` is a safe default.
   - **Opt-in, off, upstream**: a line in `opt-in.txt`, `off.txt` or `upstream.txt`; each file's comments show the format.
4. **Write it**, then run `bin/sync`. It stops with one line naming any problem; fix that and run it again until it ends with "Synced".
5. **Commit** with the repo's version control (`jj` when the repo has `.jj/`), a Conventional Commits message scoped to the folder, e.g. `feat(ana): add release-notes skill` or `feat(shared): add review rule`. A `shared/` change goes on a new branch named `<me>/<topic>`: tell the user it needs the team's agreement through a merge request. Leave pushing to the user.
6. **Tell the user** what changed and that a new chat loads it.
