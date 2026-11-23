# Changelog

Each release names its `agentfiles.txt` format. When the format changes, its entry says what a team repo must change; releases that keep the format ask nothing of a team.

## 0.3.1 (format v2)

The starter's rule files are named for what the agent is doing when their rules apply, and the agentfiles skill files new rules the same way. A team repo changes nothing; one that wants the new names renames its files, since rule names are unchanged.

- `agent-collaboration.md` is `replies.md`, `evidence.md` is `facts.md` and `projects.md` is `tickets.md`.
- A new team repo's README says sync needs a path without spaces.

## 0.3.0 (format v2)

Presets give way to templates, copied once into a new team repo ([ADR 0002](docs/adr/0002-templates-are-copied-once.md)), and the core gets a rule.

- `bin/init <path> [--template starter]` makes a new team repo: `shared/`, a `README.md`, and the template's files, which are the team's from then on. `bin/sync` no longer creates `shared/` and stops when it's missing.
- `use preset`, `off preset` and a team repo's `presets/` are gone; the `pocock`, `habits` and `recommended` presets became one template, `templates/starter/`.
- The core adds the rule `agentfiles-first`, which sends skill and rule changes through the agentfiles skill; nobody can turn it off. The skill no longer puts `shared/` changes on a branch: it follows the team's rules, and asks before pushing where they say nothing.
- The core moved to `core/` and the scaffolding to `scaffolding/`; `bin/` holds only scripts.

**What a team repo must change:** in every `agentfiles.txt`, write `format v2`. Replace each `use preset <name>` with the lines of `templates/starter/agentfiles.txt`, copy in the files of `templates/starter/rules/` the team wants, replace the commented forms in each `people/<name>/agentfiles.txt` with those of `scaffolding/person/agentfiles.txt` (they still list presets), and delete any `off preset` lines and `presets/` folder (move its contents into `shared/` or a person's folder). A rule of your own named `agentfiles-first` now clashes with the core's: delete it.

## 0.2.0 (format v1)

The tool is called agentfiles; "starter" is gone from its docs and output. A team repo changes nothing.

- Init scripts get the agentfiles repo's path as `$AGENTFILES`, no longer `$STARTER`.
- Sync's summary marks files from the agentfiles repo with `agentfiles:`, no longer `starter:`.
- The repo is github.com/tsterker/agentfiles; the old agentfiles-starter URL redirects, so existing clones pull as before.
- `--me` is optional: without it, sync gets `shared/` only and creates no person folder.
- `--repo` adds a `README.md` to a team repo that has none, saying what it is and how to set it up.

## 0.1.0 (format v1)

The starter becomes a tool that reads a team repo ([ADR 0001](docs/adr/0001-agentfiles-is-a-tool.md)).

- `bin/sync --repo <path> --me <name>` points it at a team repo once and creates `shared/` and `people/<me>/` there.
- One `agentfiles.txt` per source replaces `opt-in.txt`, `off.txt`, `keep.txt` and `upstream.txt`: `use`, `follow`, `off` and `keep` lines, starting with `format v1`.
- Git sources are fetched into `~/.cache/agentfiles/` instead of copied into a repo; `use git` takes a tag or full commit, `follow git` a branch.
- Presets `pocock`, `habits` and `recommended` replace the starter's `shared/`.

**From a fork of an earlier starter:** start the team repo fresh. Move your `shared/` and `people/` folders into it, and turn each list file into `agentfiles.txt` lines: an `opt-in.txt` line becomes `use person`, `use skill` or `use folder`; an `upstream.txt` line becomes `use git`; `off.txt` and `keep.txt` lines become `off <kind>` and `keep` lines. Committed `upstream/` copies go.
