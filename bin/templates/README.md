# {{folder}}

The skills and rules our coding agents share (Claude Code, Codex, Cursor, OpenCode). This repo is ours to change; [agentfiles]({{agentfiles}}) is the tool that puts it in place on each machine, which we pull and never edit.

## Set up

```sh
git clone {{agentfiles}}.git ~/projects/agentfiles
git clone {{origin}} ~/projects/{{folder}}
~/projects/agentfiles/bin/sync --repo ~/projects/{{folder}} --me <your name>
```

`--me` creates your own folder in `people/`; leave it out to get `shared/` only. After every pull of either repo, run `bin/sync` again and start a new chat.

## Layout

```
shared/           what everyone gets; change it through a merge request
people/<name>/    one person's own skills and rules; push without asking
presets/<name>/   optional: the team's own presets
```

Each folder's `agentfiles.txt` says what else it uses, turns off and keeps; the forms are in the agentfiles README. Or ask your agent: "make that a skill of mine", "turn off X", "use Ana's review skill".
