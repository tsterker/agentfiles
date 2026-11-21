# agentfiles-starter

One repo that gives a team's coding agents (Claude Code, Codex, Cursor, OpenCode) the same skills and rules, and gives every person a folder of their own that colleagues can borrow from.

- **Skill**: a folder with a `SKILL.md` that teaches an agent one kind of task. The agent always sees its name and description and reads the rest when a task fits.
- **Rule**: one line every agent reads in every chat, shaped `- **name**: When <situation>: <do>`. Each one costs attention in every chat, so keep them few.

The other terms are in [GLOSSARY.md](GLOSSARY.md).

## Principles

1. **Fail loudly, never guess.** Anything unexpected stops sync with one line saying what was expected and what was found.
2. **Simple until it hurts.** Build for cases someone has hit; stop on the rest. Anyone can read `bin/` in one sitting.
3. **Shared is agreed, personal is free.** Your folder is yours; everything else is collaboration.
4. **Nothing unasked.** A colleague's skills reach you only when you opt in. Sync never moves or replaces anything it didn't make unless you run `--clean`.
5. **All or nothing.** Sync either owns every folder and file your harnesses read skills and rules from, or changes nothing and shows its plan. It leaves names in `keep.txt` alone, and reports the subagents, hooks, MCP servers and plugins it doesn't manage.
6. **Git is the archive.** Delete what only you use; turn off what others still use.

## Layout

```
shared/                          everyone gets this; changes are agreed with the team
  skills/…/<name>/SKILL.md       hand-made skills, grouped in subfolders as you like
  rules/*.md                     rules: every markdown file, taken as it is
  init/*.sh                      setup links can't do; run on every sync
  keep.txt                       names other tools install where sync owns everything
  upstream.txt                   skills to copy in from other git repos
  upstream/                      what sync copied in from upstream.txt; commit it
people/<you>/                    yours; push without asking
  (the same six)
  opt-in.txt                     skills from outside your folder
  off.txt                        skills and init scripts you don't want
bin/sync
bin/probe                        checks that every harness sees what sync put in place
```

`opt-in.txt`, `off.txt`, `keep.txt` and `upstream.txt` explain their own format in comments. Everything after a `#` is skipped.

## Use

The first time, run `bin/sync --me <name>`. It creates `people/<name>/` with the files above and a rule, `rules/me.md`, that tells your agent who you are. Make that rule yours: add the names you go by in tickets and chat, and anything else your agent should know about you.

**Your existing setup.** If none of your harnesses has skills or rules yet, the first `bin/sync` sets everything up. Otherwise it changes nothing in your harnesses, copies no upstream skills, and lists what it would put in place and what's in its way. Adjust your folder (opt-ins, upstreams, `keep.txt`, `off.txt`) and run it again until the list looks right. Then `bin/sync --clean` moves what's in its way to `~/.cache/agentfiles/removed-<date>/`; nothing is deleted. From then on, a plain `bin/sync` keeps it that way.

The first sync that sets up also copies the skills listed in `shared/upstream.txt` into `shared/upstream/`. Read them, delete the lines you don't want, and commit the rest: from then on, everyone's sync uses the committed copies.

After that, run `bin/sync` whenever you pull or add or remove a skill or rule, then start a new chat. Edits inside an existing skill work at once, and so do rule edits for Claude Code; Codex, OpenCode and Cursor get rule edits on the next sync.

Or just ask your agent: "make that a skill of mine", "turn off X", "use Ana's review skill". The shared `agentfiles` skill knows this repo.

| Want to | Do |
|---|---|
| add a skill | `people/<you>/skills/<name>/SKILL.md` |
| add a rule | a line in `people/<you>/rules/<topic>.md` |
| use a colleague's skill | `ana/review` (or `ana/*`) in your `opt-in.txt` |
| use skills from a folder on your disk | its path in your `opt-in.txt`; linked live, never committed |
| skip a skill or init script you'd otherwise get | its name in your `off.txt` |
| use skills from another git repo | its URL in `upstream.txt` (a repo, or a `/tree/<ref>/<path>` link to part of it), then `bin/sync` and commit `upstream/` with the line |
| get a newer copy of an upstream skill | delete its folder under `upstream/`, then `bin/sync` |
| run setup that links can't do | a script in `init/`; it must be safe to run again, and its failure stops sync |
| let an app install its skill where sync owns everything | the skill's name in `keep.txt`, and an `init/` script that checks the app did |
| give a skill or rule to everyone | move it into `shared/`, agreed with the team |
| check that every harness sees your skills and rules | `bin/probe`, once sync has set up; it asks each harness for a throwaway rule and skill, then removes them |
| take over from another setup | `bin/sync --clean` moves what sync didn't make to `~/.cache/agentfiles/removed-<date>/` |

Skill names must be unique across everything you get; sync stops on a clash. Starting your own with your name (`tim-foo`) avoids most of them.

## Tune it as you go

Your agent's habits come from these rules and skills, so you change them by talking to it. When it does something you don't like, mid-task or after (asks too often, plays it too safe, skips a step), ask it "why did you do that, which rule or skill made you?", then "change that for me". After a longer session, run the `retro` skill (`/retro` in Claude Code) and it suggests what to improve. Changes land in your folder; for a shared rule, the agent prepares a change for the team.

## What sync changes on your Mac

Once you hand it over, sync owns these, all or nothing:

- `~/.claude/skills/` and `~/.agents/skills/` (Codex): links to your skills. Also `~/.codex/skills/`, `~/.cursor/skills/` and `~/.config/opencode/skills/`, which it keeps empty. Cursor reads all four, so it lists each skill twice.
- `~/.claude/rules/`: links to your rules. `~/.codex/AGENTS.md` and `~/.config/opencode/AGENTS.md`: your rules as text. `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.override.md`: kept absent, since they'd add to or replace those; rules go in `rules/`.
- `~/.cursor/plugins/local/`: your rules as the plugin `agentfiles-rules`, which the Cursor IDE and T3 Code read. `~/.cursor/rules/`: one rule that makes the `cursor-agent` CLI, which reads no plugin, warn in every reply that it has none of your rules.

It lists the subagents, hooks, MCP servers and plugins it finds, and runs your init scripts. It needs `git` and `jq` and stops at the start if either is missing.

## Remove it

```sh
while IFS="$(printf '\t')" read -r l t; do [ "$(readlink "$l")" != "$t" ] || rm "$l"; done < ~/.cache/agentfiles/links
rm -rf ~/.codex/AGENTS.md ~/.config/opencode/AGENTS.md ~/.cursor/plugins/local/agentfiles-rules ~/.cursor/rules/agentfiles-cli-guard.mdc ~/.cache/agentfiles/links ~/.cache/agentfiles/written
```

What `--clean` moved aside stays in `~/.cache/agentfiles/removed-<date>/`.
