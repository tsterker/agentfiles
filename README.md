# agentfiles-starter

A tool that gives a team's coding agents (Claude Code, Codex, Cursor, OpenCode) the same skills and rules, from a team repo where everyone also has a folder of their own that colleagues can borrow from. You clone the starter and pull it; you never edit it. What you tune lives in your team repo.

- **Skill**: a folder with a `SKILL.md` that teaches an agent one kind of task. The agent always sees its name and description and reads the rest when a task fits.
- **Rule**: one line every agent reads in every chat, shaped `- **name**: When <situation>: <do>`. Each one costs attention in every chat, so keep them few.

The other terms are in [GLOSSARY.md](GLOSSARY.md); why it's a tool and not a fork: [docs/adr/0001-the-starter-is-a-tool.md](docs/adr/0001-the-starter-is-a-tool.md).

## Principles

1. **Fail loudly, never guess.** Anything unexpected stops sync with one line saying what was expected and what was found.
2. **Simple until it hurts.** Build for cases someone has hit; stop on the rest. Anyone can read `bin/` in one sitting.
3. **Shared is agreed, personal is free.** Your folder is yours; everything else is collaboration.
4. **Nothing unasked.** A preset, a colleague's skills or a git source reaches you only through a `use` line, yours or your team's. Sync never moves or replaces anything it didn't make unless you run `--clean`.
5. **All or nothing.** Sync either owns every folder and file your harnesses read skills and rules from, or changes nothing and shows its plan. It leaves `keep` names alone, and reports the subagents, hooks, MCP servers and plugins it doesn't manage.
6. **Git is the archive.** Delete what only you use; turn off what others still use.

## Layout

```
the starter (this repo; pull it, never edit it)
  bin/sync, bin/probe
  bin/skills/agentfiles/         the core: everyone gets it
  presets/<name>/                pocock, habits, and recommended, which uses both
  CHANGELOG.md                   what each release changes, and what a team repo must change

your team repo (your own git project)
  shared/                        everyone gets this; changes are agreed with the team
  people/<you>/                  yours; push without asking
  presets/<name>/                optional: the team's own presets

each of shared/, people/<x>/ and presets/<name>/ (a source):
  agentfiles.txt                 what this source uses, turns off and keeps
  skills/…/<name>/SKILL.md       hand-made skills, grouped in subfolders as you like
  rules/*.md                     rules: every markdown file, taken as it is
  init/*.sh                      setup links can't do; run on every sync
```

## agentfiles.txt

Every line is `<verb> <kind> <what>`; everything after a `#` is skipped. Line order doesn't matter, and `off` always wins wherever it sits, except `off preset`, which works only in `shared/` and your own file. Every name must be unique across what you get: sync stops on a clash naming both, and `off` drops every skill or rule of that name, so a replacement for one you turn off needs a new name. Starting your own with your name (`tim-foo`) avoids most clashes.

```
format v1                                   the file's format; sync stops on any other (CHANGELOG.md)
use    preset recommended                   a preset from the starter's or the team repo's presets/
use    person ana                           a colleague's skills and rules; their own lines and init scripts stay theirs
use    skill  ana-review                    one skill from a colleague's folder
use    folder ~/projects/my-skills          a folder on your disk, linked live
use    git    https://github.com/o/r/tree/v1.3.2/skills    a tag or full commit, fetched once into ~/.cache/agentfiles
follow git    https://github.com/o/r/tree/main/skills      a branch, fetched on every sync
off    skill  grilling                      also: off rule <name>, off init <file>.sh, off preset <name>
keep   my-app                               a name another tool installs in the folders sync owns
```

A preset, folder or git source uses other sources the same way, read once each. A `git` source is a repo, or a `/tree/<ref>/<path>` (GitLab: `/-/tree/`) link copied from the browser; a ref containing `/` isn't supported. Nothing from git is committed: to own a skill's text, copy it into your folder under a new name.

**Following a branch** means whoever can push to it shapes your agent on your next sync, and teammates who synced at different times hold different commits. Sync lists every followed source in its summary, stops when a fetch fails, and refuses to run a followed source's init scripts: `off init` them, or pin the source with `use`.

## Use

Clone the starter, create or clone your team's git project, then run once:

```sh
bin/sync --repo ~/projects/agentfiles-<team> --me <name>
```

It remembers both, creates `shared/agentfiles.txt` (with `use preset recommended`) if the team repo has none, and `people/<name>/` with an `agentfiles.txt` listing the forms and a rule, `rules/me.md`, that tells your agent who you are. Make that rule yours: add the names you go by in tickets and chat, and anything else your agent should know about you. Commit and push the team repo.

**Your existing setup.** If none of your harnesses has skills or rules yet, the first `bin/sync` sets everything up. Otherwise it changes nothing in your harnesses and lists what it would put in place and what's in its way. Adjust your `agentfiles.txt` and run it again until the list looks right. Then `bin/sync --clean` moves what's in its way to `~/.cache/agentfiles/removed-<date>/`; nothing is deleted. From then on, a plain `bin/sync` keeps it that way.

After that, run `bin/sync` whenever you pull either repo or add or remove a skill or rule, then start a new chat. Edits inside an existing skill work at once, and so do rule edits for Claude Code, except in a rule file with a rule turned off; Codex, OpenCode and Cursor get rule edits on the next sync.

Or just ask your agent: "make that a skill of mine", "turn off X", "use Ana's review skill". The core `agentfiles` skill knows both repos.

| Want to | Do |
|---|---|
| add a skill | `people/<you>/skills/<name>/SKILL.md` |
| add a rule | a line in `people/<you>/rules/<topic>.md` |
| use or drop a preset, a colleague's skills, a folder or a git source | a `use`, `follow` or `off` line in your `agentfiles.txt` |
| run setup that links can't do | a script in `init/`; it must be safe to run again, and its failure stops sync |
| let an app install its skill where sync owns everything | a `keep` line, and an `init/` script that checks the app did |
| give a skill, rule or line to everyone | move it into `shared/`, agreed with the team |
| move to a new starter release | pull the starter; when sync stops on the format, `CHANGELOG.md` says what to change |
| check that every harness sees your skills and rules | `bin/probe`, once sync has set up; it asks each harness for a throwaway rule and skill, then removes them |

## Tune it as you go

Your agent's habits come from these rules and skills, so you change them by talking to it. When it does something you don't like, mid-task or after (asks too often, plays it too safe, skips a step), ask it "why did you do that, which rule or skill made you?", then "change that for me". After a longer session, run the `retro` skill (`/retro` in Claude Code) and it suggests what to improve. Changes land in your folder; for a shared rule, the agent prepares a change for the team.

## What sync changes on your Mac

Once you hand it over, sync owns these, all or nothing:

- `~/.claude/skills/` and `~/.agents/skills/` (Codex): links to your skills. Also `~/.codex/skills/`, `~/.cursor/skills/` and `~/.config/opencode/skills/`, which it keeps empty. Cursor reads all four, so it lists each skill twice.
- `~/.claude/rules/`: links to your rule files, or to a copy without the rules you turned off. `~/.codex/AGENTS.md` and `~/.config/opencode/AGENTS.md`: your rules as text. `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.override.md`: kept absent, since they'd add to or replace those; rules go in `rules/`.
- `~/.cursor/plugins/local/`: your rules as the plugin `agentfiles-rules`, which the Cursor IDE and T3 Code read. A plugin another tool puts there needs a `keep` line. `~/.cursor/rules/`: one rule that makes the `cursor-agent` CLI, which reads no plugin, warn in every reply that it has none of your rules.
- `~/.cache/agentfiles/`: git sources, rule copies, and what `--clean` moved aside.

It lists the subagents, hooks, MCP servers and plugins it finds, and runs your init scripts. It needs `git` and `jq` and stops at the start if either is missing.

## Remove it

```sh
while IFS="$(printf '\t')" read -r l t; do [ "$(readlink "$l")" != "$t" ] || rm "$l"; done < ~/.cache/agentfiles/links
rm -rf ~/.codex/AGENTS.md ~/.config/opencode/AGENTS.md ~/.cursor/plugins/local/agentfiles-rules ~/.cursor/rules/agentfiles-cli-guard.mdc ~/.cache/agentfiles/{links,written,rules,git,follow}
```

What `--clean` moved aside stays in `~/.cache/agentfiles/removed-<date>/`.
