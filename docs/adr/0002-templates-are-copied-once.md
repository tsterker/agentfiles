# Templates are copied once; the core runs only agentfiles

Agentfiles ships templates, not presets. `bin/init <path> --template starter` copies a template's `agentfiles.txt` and rules into a new team repo's `shared/` once; from then on those files are the team's, and nothing links them back. The core holds only what makes agentfiles itself work: the `agentfiles` skill and its `agentfiles-first` rule. How an agent works on anything else, branches and pushing included, comes from the team repo.

## Considered options

- **Presets as live sources** (`use preset <name>`). One line brought a whole set of skills and rules, two hops deep, and pulling agentfiles changed what a team got without any line of theirs changing. Nobody saw what shaped their agent unless they went looking.
- **Presets as pinned git sources** (`use git …/tree/<tag>/presets/<name>`). Versioned, but still a set behind one line, and its rules stayed agentfiles' text rather than the team's.
- **The agentfiles skill copies a preset on request.** No new script, but it teaches the skill machinery for a step taken once.
- **Recording where copied files came from.** It would let an update report a template's changes, at the cost of an origin every reader carries for good after a one-off start.
- **Workflow defaults in the core.** The core skill put `shared/` changes on a branch for a merge request, and a team that commits on main had to write a rule overriding it.

## Consequences

- Format v2 drops `use preset`, `off preset` and a team repo's `presets/`.
- A template's later changes never reach a team; one that wants them reads the agentfiles diff.
- Creating a team repo (`bin/init`) and joining one (`bin/sync --repo`) are separate commands, and init stops on a repo that already has `shared/`.
- No team can turn off the core rule, so sync's summary names the core on every run.
