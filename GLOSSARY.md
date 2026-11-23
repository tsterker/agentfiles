# Agentfiles

A tool, cloned once and never edited, that gives everyone's coding agents on a team the same skills and rules from the team's own repo, where each person also has a space of their own that colleagues can use too.

## Language

### What gets delivered

**Skill**:
A folder with a `SKILL.md` that teaches an agent one kind of task; the agent sees its name and description always and reads the rest when a task fits.
_Avoid_: command, prompt, plugin

**Rule**:
One line of always-on guidance, shaped `When <situation>: <do>` and named in bold, loaded into every agent session.
_Avoid_: instruction, policy, memory

**Harness**:
An agent app that loads skills and rules: Claude Code, Codex, Cursor or OpenCode.
_Avoid_: agent, tool, client, IDE

**Init script**:
A script that sync runs on every run, for setup that links alone can't do; it must be safe to run again, and its failure stops sync.
_Avoid_: plugin, hook, installer

### Where it comes from

**Agentfiles**:
The public tool: the scripts, the core, the templates it ships and the docs, in the agentfiles repo that teams clone and pull and never edit.
_Avoid_: starter, upstream, base

**Core**:
What agentfiles gives everyone, with no way to turn it off, and only what makes agentfiles itself work: the `agentfiles` skill, its `agentfiles-first` rule, and the names the harnesses themselves keep in the folders sync owns.
_Avoid_: defaults, base, built-ins

**Team repo**:
A team's own git repository of shared and person folders, which agentfiles reads.
_Avoid_: fork, config repo, dotfiles

**Source**:
A folder that brings skills, rules and init scripts, and an `agentfiles.txt` saying what else it uses: shared, a person's folder, a folder on disk, or a git repository or part of one.
_Avoid_: package, module, bundle

**Shared**:
The source everyone on the team gets: what the team agreed on.
_Avoid_: team, global, common

**Person**:
A colleague with a folder of their own in the team repo, where they change anything without asking.
_Avoid_: user, member, owner

**Me**:
The person a machine syncs for; an agent on that machine works for them.
_Avoid_: current user, self, account

**Template**:
A folder of rules, skills and `agentfiles.txt` lines that agentfiles ships and `bin/init` copies once into a new team repo's `shared/`; from then on the copy is the team's, and nothing links it back.
_Avoid_: preset, profile, bundle, pack

### How it reaches a machine

**Use**:
A line choosing a source to get besides shared and one's own folder; nothing reaches anyone without one, theirs or their team's.
_Avoid_: opt-in, subscribe, import

**Follow**:
A use of a git branch rather than a tag or commit, fetched again on every sync.
_Avoid_: track, latest, float

**Off**:
A line dropping a skill, rule or init script one would otherwise get, wherever it comes from except the core.
_Avoid_: disable, park, mute, blocklist

**Keep**:
A name sync leaves alone in the folders it owns, because another tool installs it there, such as an app's own skill.
_Avoid_: allow, ignore, whitelist, exception

**Format**:
The version of the `agentfiles.txt` language a file is written in; agentfiles reads exactly one and stops on any other.
_Avoid_: schema, version, edition

**Sync**:
Making a machine's harnesses match the team repo for one person, or for no one in particular: the core, shared, their own folder if they have one, and every source these use, minus what is off. It owns the folders and files those harnesses read skills and rules from, all or nothing, from the first sync that sets up: right away on a machine with nothing in the way, otherwise after `--clean`.
_Avoid_: install, deploy, update
