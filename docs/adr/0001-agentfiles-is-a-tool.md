# Agentfiles is a tool, not a fork

_Its presets are superseded by [0002](0002-templates-are-copied-once.md): templates copied once._

Teams clone agentfiles and pull it; they never edit it. Their skills and rules live in a team repo of their own, which its `bin/sync` reads. Agentfiles claims only `bin/` (with the core), `presets/` and its docs, so it can ship opinionated presets without ever conflicting with what a team has tuned, and a team takes any of it, or none, through lines in its `agentfiles.txt`.

## Considered options

- **Fork and merge.** A team forks agentfiles and merges its changes. Its defaults lived in `shared/`, the same files the team was told to tune, so every later change to them conflicted or quietly overrode the team; keeping the fork's commits out of the public repo took two clones, a push URL that leads nowhere and jj setup. A git submodule pinning the tool inside the team repo would let a team move in one push, but jj doesn't support submodules.
- **Commit copies of third-party skills.** Owning the exact text gave a diff for every change, but put other authors' skills into this public repo and gave beginners a commit step. Pinned fetches into the cache give a one-line diff per change instead; to own a skill's text, copy it into your folder under a new name.

## Consequences

- A team repo declares the format of its `agentfiles.txt` (`format v1`), not the agentfiles version. Releases that keep the format never ask a team to edit anything; the tool reads only the current format and stops on any other, pointing to `CHANGELOG.md`.
- The presets agentfiles ships reach each person when they pull it, not when their team decides. A team that wants to decide pins them with `use git` links to a tag of the agentfiles repo; `recommended` names its parts with `use preset`, which reads the local clone, so such a team pins `pocock` and `habits` instead.
