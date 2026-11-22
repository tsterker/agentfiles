# Changelog

Each release names its `agentfiles.txt` format. When the format changes, its entry says what a team repo must change; releases that keep the format ask nothing of a team.

## 0.2.0 (format v1)

The tool is called agentfiles; "starter" is gone from its docs and output. A team repo changes nothing.

- Init scripts get the agentfiles repo's path as `$AGENTFILES`, no longer `$STARTER`.
- Sync's summary marks files from the agentfiles repo with `agentfiles:`, no longer `starter:`.

## 0.1.0 (format v1)

The starter becomes a tool that reads a team repo ([ADR 0001](docs/adr/0001-agentfiles-is-a-tool.md)).

- `bin/sync --repo <path> --me <name>` points it at a team repo once and creates `shared/` and `people/<me>/` there.
- One `agentfiles.txt` per source replaces `opt-in.txt`, `off.txt`, `keep.txt` and `upstream.txt`: `use`, `follow`, `off` and `keep` lines, starting with `format v1`.
- Git sources are fetched into `~/.cache/agentfiles/` instead of copied into a repo; `use git` takes a tag or full commit, `follow git` a branch.
- Presets `pocock`, `habits` and `recommended` replace the starter's `shared/`.

**From a fork of an earlier starter:** start the team repo fresh. Move your `shared/` and `people/` folders into it, and turn each list file into `agentfiles.txt` lines: an `opt-in.txt` line becomes `use person`, `use skill` or `use folder`; an `upstream.txt` line becomes `use git`; `off.txt` and `keep.txt` lines become `off <kind>` and `keep` lines. Committed `upstream/` copies go.
