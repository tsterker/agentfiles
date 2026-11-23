# {{clone}}

The skills and rules our coding agents share (Claude Code, Codex, Cursor, OpenCode). This repo is ours to change; [agentfiles]({{agentfiles}}) is the tool that puts it in place on each machine, which we pull and never edit.

## Set up

In any folder you keep projects in, as long as its path has no spaces (sync stops on one):

```sh
git clone {{agentfiles}}.git
git clone {{origin}}
agentfiles/bin/sync --repo {{clone}} --me <your name>
```

`--me` creates your own folder in `people/`; leave it out to get `shared/` only. After every pull of either repo, run `bin/sync` again and start a new chat. Or ask your agent to "update agentfiles".

## Layout

```
shared/           what everyone gets, agreed with the team
people/<name>/    one person's own skills and rules
```

Everything in `shared/` is the team's: read each file, then change or delete what you don't agree with.

Each folder's `agentfiles.txt` says what else it uses, turns off and keeps; the forms are in the agentfiles README. Or ask your agent: "make that a skill of mine", "turn off X", "use Ana's review skill".
