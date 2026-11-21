---
name: agentfiles
description: Agentfiles, the repo of the user's skills and rules. Use to add, change or remove a skill or rule, use a colleague's skill, turn one off, copy skills in from another git repo, or update the repo and explain what changed. Offer it when the user says "make that a skill/rule", "remember to always…", "turn off X", "use Ana's Y", "update agentfiles", or a lesson worth keeping comes up; act once they agree.
---

# Agentfiles

First, **find the repo and me.** The repo is `git -C "$(cd <this skill's folder> && pwd -P)" rev-parse --show-toplevel`; me is the one word in its `.me`. Its `README.md` has the layout and principles. Use the repo's version control throughout: `jj` when it has `.jj/`, else `git`.

## Change something

1. **Pick the place.** Work in `people/<me>/`. Use `shared/` only when the user says it's for everyone or the team.
2. **Pick the kind.**
   - **Rule**: guidance that must hold in every chat, in one line: `- **<name>**: When <situation>: <do>.` Add it to the fitting `rules/<topic>.md`, or a new topic file. Rules cost attention in every chat, so prefer a skill when the guidance matters only for some tasks.
   - **Skill**: a procedure or knowledge needed for some tasks: `skills/<name>/SKILL.md`, its frontmatter `name` equal to the folder name and a `description` saying what it is and when to use it. The name must be unique across everything the user gets; `<me>-<name>` is a safe default.
   - **Opt-in, off, upstream**: a line in `opt-in.txt`, `off.txt` or `upstream.txt`; each file's comments show the format.
3. **Write it**, then run `bin/sync`. It stops with one line naming any problem; fix that and run it again until it ends with "Synced".
4. **Commit** with a Conventional Commits message scoped to the folder, e.g. `feat(ana): add release-notes skill` or `feat(shared): add review rule`. A `shared/` change goes on a new branch named `<me>/<topic>`: tell the user it needs the team's agreement through a merge request. Leave pushing to the user.
5. **Tell the user** what changed and that a new chat loads it.

## Update

1. **Note the current commit**, then pull: `git pull --rebase`, or with jj `jj git fetch` and rebase the user's own commits onto `main@origin`.
2. **Run `bin/sync`** until it ends with "Synced".
3. **Explain what changed** between the noted commit and the new one, from the diff, in plain words, grouped by what it means for the user:
   - new, changed or removed skills and rules they get (`shared/`, `people/<me>/`, the colleagues in their `opt-in.txt`), and how each changes their agent's behaviour;
   - new skills in colleagues' folders they don't get yet, as opt-in candidates;
   - changes to `bin/` or the README that alter how they use the repo.
4. **Tell the user** that a new chat loads the new skills and rules.
