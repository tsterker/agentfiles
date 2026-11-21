# Fork it for your team

The starter, this repo on GitHub, stays generic. Your team's fork adds the team's shared skills, rules and people, and merges the starter's changes in. Three rules keep it safe and the merges quiet:

1. **Two clones.** The fork lives in its own clone, with the starter as a remote it can fetch from but not push to. Changes to the starter happen in a separate clone of the starter that has no remote for the fork. The team's commits never exist where they could reach the public repo.
2. **Merge, never rebase.** Colleagues pull the fork's `main`, so the starter comes in as a merge commit; a rebase would rewrite the history they built on.
3. **Add files, leave `bin/` alone.** Team content goes in new files (`shared/rules/<team>.md`, `people/<name>/`), which never conflict with the starter. Edits to the starter's files conflict only when it changes the same lines. A change to `bin/` or the docs goes to the starter and comes back with the next merge.

Make the fork's project private or internal: whoever can read it reads every rule and person folder in it.

## Set up the fork

Create an empty project on your git host, then use git or jj. Both clone the starter, rename its remote to `starter`, and give it a push URL that leads nowhere, so a push to it fails naming `no-push--the-starter-is-read-only`.

**git**

```sh
git clone https://github.com/tsterker/agentfiles-starter.git ~/projects/agentfiles-<team>
cd ~/projects/agentfiles-<team>
git remote rename origin starter
git remote set-url --push starter no-push--the-starter-is-read-only
git remote add origin git@<host>:<group>/<project>.git
git push -u origin main
```

**jj**

```sh
jj git clone https://github.com/tsterker/agentfiles-starter.git ~/projects/agentfiles-<team>
cd ~/projects/agentfiles-<team>
jj git remote rename origin starter
git config remote.starter.pushurl no-push--the-starter-is-read-only
jj git remote add origin git@<host>:<group>/<project>.git
jj bookmark untrack main --remote=starter
jj bookmark track main --remote=origin
jj config set --repo git.fetch '["origin", "starter"]'
jj git push -b main
jj config set --repo 'revset-aliases."trunk()"' main@origin
jj config set --repo revsets.log "$(jj config get revsets.log) | trunk()..present(main@starter)"
```

jj moves a tracked bookmark on every fetch, so `main` tracks only the fork's; jj then also refuses to push `main` to the starter. The last line makes `jj log` show the starter's commits the fork hasn't merged yet.

Colleagues clone the fork and run `bin/sync --me <name>`; they need no `starter` remote. Run `bin/sync` from the fork's clone yourself too: sync links your harnesses to the clone it runs from.

## Merge the starter's changes

In the fork's clone:

**git**

```sh
git fetch starter
git log --oneline main..starter/main   # what the merge brings in
git merge starter/main
git push
```

**jj**

```sh
jj git fetch
jj new main main@starter -m "merge: agentfiles-starter"
jj bookmark set main -r @
jj git push -b main
```

Then run `bin/sync` and tell the team what changed; the `agentfiles` skill explains a diff.

## Change the starter

Change `bin/` or the docs in a clone of the starter and send a pull request, or push if you maintain it. To try a change in the fork first, add that clone as one more remote by its path and merge from it like from `starter`.

The clones can't stop you typing team content into the starter's clone by hand. A team email set only in the fork's clone (`git config user.email`, or `jj config set --repo user.email`) makes such a slip stand out in the starter's log.
