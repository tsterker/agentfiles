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
An agent app that loads skills and rules: Claude Code, Codex or Cursor.
_Avoid_: agent, tool, client, IDE

### Where it comes from

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
A person's choice to not get a skill they would otherwise get, without removing it from the repo.
_Avoid_: disable, park, mute, blocklist

**Sync**:
Making a machine's harnesses match the repo for one person: their shared, own, opted-in and upstream skills and rules, minus those turned off.
_Avoid_: install, deploy, update

**Init script**:
A script that sync runs on every run, for setup that links alone can't do; it must be safe to run again, and its failure stops sync.
_Avoid_: plugin, hook, installer
