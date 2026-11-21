# agentfiles-starter

One repo that gives a team's coding agents (Claude Code, Codex, Cursor) the same skills and rules, and gives every person a folder of their own that colleagues can borrow from.

- **Skill**: a folder with a `SKILL.md` that teaches an agent one kind of task. The agent always sees its name and description and reads the rest when a task fits.
- **Rule**: one line every agent reads in every chat, shaped `- **name**: When <situation>: <do>`. Each one costs attention in every chat, so keep them few.

The other terms are in [GLOSSARY.md](GLOSSARY.md).

## Principles

1. **Fail loudly, never guess.** Anything unexpected stops sync with one line saying what was expected and what was found.
2. **Simple until it hurts.** Build for cases someone has hit; stop on the rest. Anyone can read `bin/` in one sitting.
3. **Shared is agreed, personal is free.** Your folder is yours; everything else is collaboration.
4. **Nothing unasked.** A colleague's skills reach you only when you opt in.
5. **Sync owns its links, and only its links.** It creates and removes its own freely; anything else it reports, and moves aside only when asked.
6. **Git is the archive.** Delete what only you use; turn off what others still use.

## Layout

```
shared/                          everyone gets this; changes are agreed with the team
  skills/…/<name>/SKILL.md       hand-made skills, grouped in subfolders as you like
  rules/*.md                     rules: every markdown file, taken as it is
  init/*.sh                      setup links can't do; run on every sync
  upstream.txt                   skills to copy in from other git repos
  upstream/                      what sync copied in from upstream.txt; commit it
people/<you>/                    yours; push without asking
  (the same five)
  opt-in.txt                     skills from outside your folder
  off.txt                        skills you don't want
bin/sync
```

`opt-in.txt`, `off.txt` and `upstream.txt` explain their own format in comments. Lines starting with `#` are skipped.

## Use

The first time, run `bin/sync --me <name>`. It creates `people/<name>/` with the files above and a rule, `rules/me.md`, that tells your agent who you are. Make that rule yours: add the names you go by in tickets and chat, and anything else your agent should know about you.

After that, run `bin/sync` whenever you pull or add or remove a skill or rule, then start a new chat. Edits inside an existing skill or rule work at once.

Or just ask your agent: "make that a skill of mine", "turn off X", "use Ana's review skill". The shared `agentfiles` skill knows this repo.

| Want to | Do |
|---|---|
| add a skill | `people/<you>/skills/<name>/SKILL.md` |
| add a rule | a line in `people/<you>/rules/<topic>.md` |
| use a colleague's skill | `ana/review` (or `ana/*`) in your `opt-in.txt` |
| use skills from a folder on your disk | its path in your `opt-in.txt`; linked live, never committed |
| skip a skill you'd otherwise get | its name in your `off.txt` |
| use skills from another git repo | its URL in `upstream.txt` (a repo, or a `/tree/<ref>/<path>` link to part of it), then `bin/sync` and commit `upstream/` with the line |
| get a newer copy of an upstream skill | delete its folder under `upstream/`, then `bin/sync` |
| run setup that links can't do | a script in `init/`; it must be safe to run again, and its failure stops sync |
| give a skill or rule to everyone | move it into `shared/`, agreed with the team |
| clear out skills sync didn't put there | `bin/sync --clean` moves them to `~/.cache/agentfiles/removed-<date>/` |

Skill names must be unique across everything you get; sync stops on a clash. Starting your own with your name (`tim-foo`) avoids most of them.

## What sync changes on your Mac

- Links to your skills in `~/.claude/skills/` (Claude Code) and `~/.agents/skills/` (Codex). Cursor reads both, so it lists each skill twice.
- Your rules: links in `~/.claude/rules/`, a marked block in `~/.codex/AGENTS.md`, and `~/.cursor/rules/agentfiles.mdc`.
- Whatever your `init/` scripts do.

It needs `git` and stops at the start if it's missing.

## Remove it

```sh
while read -r l; do rm -f "$l"; done < ~/.cache/agentfiles/links
rm -rf ~/.cursor/rules/agentfiles.mdc ~/.cache/agentfiles
```

Then delete the block between the `agentfiles` markers in `~/.codex/AGENTS.md`.
