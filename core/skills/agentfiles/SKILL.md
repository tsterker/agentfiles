---
name: agentfiles
description: Agentfiles, the user's skills and rules: a team repo that the agentfiles tool syncs into every harness. Use to add, change or remove a skill or rule, use a colleague's skills or a git source, turn something off, update agentfiles or the team repo and explain what changed, or trace why the agent behaves as it does and tune that. Offer it when the user says "make that a skill/rule", "remember to always…", "turn off X", "use Ana's Y", "update agentfiles", "why did you do that", "stop doing X", or a lesson worth keeping comes up; act once they agree.
---

# Agentfiles

First, **find the two repos and me.** The agentfiles repo is `git -C "$(cd <this skill's folder> && pwd -P)" rev-parse --show-toplevel`; its `.local` names the team `repo` and, when the user has a folder there, `me`. Its `README.md` has the layout, the `agentfiles.txt` forms and the principles. You change only the team repo; agentfiles changes by pull. Use each repo's version control throughout: `jj` when it has `.jj/`, else `git`.

## Change something

1. **Pick the place.** Work in `people/<me>/` of the team repo. Use `shared/` only when the user says it's for everyone or the team. With no `me`, offer `bin/sync --me <name>` for a folder of their own, or `shared/`.
2. **Pick the kind.**
   - **Rule**: guidance that must hold in every chat, in one line: `- **<name>**: When <situation>: <do>.` Add it to the fitting `rules/<topic>.md`, or a new topic file. Rules cost attention in every chat, so prefer a skill when the guidance matters only for some tasks.
   - **Skill**: a procedure or knowledge needed for some tasks: `skills/<name>/SKILL.md`, its frontmatter `name` equal to the folder name and a `description` saying what it is and when to use it. The name must be unique across everything the user gets; `<me>-<name>` is a safe default.
   - **A line in `agentfiles.txt`**: `use` or `follow` a person, skill, folder or git source; `off` a skill, rule or init script; `keep` a name another tool installs. A git source pins a tag or full commit with `use`; `follow` a branch only when the user asks for it, after naming the risk: whoever pushes to it shapes their agent.
   - **Init script**: setup links can't do, such as installing a plugin or checking that an app installed its skill: `init/<name>.sh`, safe to run again.
3. **Write it**, then run `bin/sync` in the agentfiles repo. It stops with one line naming any problem; fix that and run it again until it ends with "Synced". When it says "Changed nothing", show the user its summary and `~/.cache/agentfiles/plan.txt`, and help them adjust their `agentfiles.txt`. Run `bin/sync --clean` only when they say so: it moves everything sync didn't make out of their harnesses.
4. **Commit** in the team repo as its rules say for branches, messages and pushing. Where they say nothing: a Conventional Commits message scoped to the folder (`feat(ana): add release-notes skill`), and ask before pushing. A `shared/` change needs the team's agreement: say so.
5. **Tell the user** what changed and that a new chat loads it.

## Tune behaviour

1. **Find the cause.** Search what the user gets for what led to the behaviour, and quote those lines: the core, `shared/`, `people/<me>/`, and every source their `agentfiles.txt` files use, fetched git sources (`~/.cache/agentfiles/git/`) included. When none did, say it's the agent's default and that a rule can change it.
2. **Propose the smallest change** and its effect:
   - the user's own rule or skill: edit it;
   - a rule or skill from shared, a colleague or git: an `off` line in their `agentfiles.txt`, plus their own replacement in `people/<me>/` under a new name when they want different wording (`off` drops every rule or skill of its name); when it would help everyone, also a shared change for the team.
3. Once they agree, continue with steps 3 to 5 of **Change something**.

## Update

1. **Note both repos' current commits**, then pull each: the team repo (`git pull --rebase`, or with jj `jj git fetch` and rebase the user's own commits onto `main@origin`), then the agentfiles repo.
2. **Run `bin/sync`** until it ends with "Synced". When it stops on a format, read the agentfiles `CHANGELOG.md` for what the team repo must change, propose that change, and continue once they agree.
3. **Explain what changed** between the noted commits and the new ones, from the diffs, in plain words, grouped by what it means for the user:
   - new, changed or removed skills and rules they get, and how each changes their agent's behaviour; for a `use git` line whose tag or commit changed, compare the two refs;
   - new skills in colleagues' folders, as candidates;
   - `CHANGELOG.md` entries and README changes that alter how they use either repo.
4. **Tell the user** that a new chat loads the new skills and rules.
