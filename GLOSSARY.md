# Agentfiles

One repo, forked by a team, that gives everyone's coding agents the same skills and rules, and gives each person a space of their own for skills and rules that colleagues can use too.

## Language

### What gets delivered

**Skill**:
A folder with a `SKILL.md` that teaches an agent one kind of task; the agent sees its name and description always and reads the rest when a task fits.
_Avoid_: command, prompt, plugin

**Rule**:
One line of always-on guidance, shaped `When <situation>: <do>`, loaded into every agent session.
_Avoid_: instruction, policy, memory

**Harness**:
An agent app that loads skills and rules: Claude Code, Codex, Cursor or OpenCode.
_Avoid_: agent, tool, client, IDE

### Where it comes from

**Starter**:
The public repo every fork comes from: the sync scripts in `bin/`, the docs, and a default `shared/`.
_Avoid_: upstream, template, base

**Fork**:
A team's own copy of the starter on its own git host, which adds the team's shared and people content and merges the starter's changes in.
_Avoid_: mirror, clone, copy

**Shared**:
The part of the repo everyone gets: skills and rules the team agreed on.
_Avoid_: team, global, core

**Person**:
A colleague with a folder of their own in the repo, where they change anything without asking.
_Avoid_: user, member, owner

**Me**:
The person a machine syncs for; an agent on that machine works for them.
_Avoid_: current user, self, account

**Upstream**:
Skills from another git repository, copied into the repo from a recipe and committed like hand-made ones, kept apart from them.
_Avoid_: third-party, external, dependency, vendor, baked

### How it reaches a machine

**Opt-in**:
A person's choice to also get skills from outside their own folder: a colleague's hand-made skill by name, or the skills in a folder on their own disk; nobody gets a colleague's skill without one.
_Avoid_: subscribe, follow, import

**Off**:
A person's choice to not get a skill or init script they would otherwise get, without removing it from the repo.
_Avoid_: disable, park, mute, blocklist

**Sync**:
Making a machine's harnesses match the repo for one person: their shared, own, opted-in and upstream skills and rules, minus those turned off. It owns the folders and files those harnesses read skills and rules from, all or nothing, from the first sync that sets up: right away on a machine with nothing in the way, otherwise after `--clean`.
_Avoid_: install, deploy, update

**Keep**:
A name sync leaves alone in the folders it owns, because another tool installs it there, such as an app's own skill.
_Avoid_: allow, ignore, whitelist, exception

**Init script**:
A script that sync runs on every run, for setup that links alone can't do; it must be safe to run again, and its failure stops sync.
_Avoid_: plugin, hook, installer
