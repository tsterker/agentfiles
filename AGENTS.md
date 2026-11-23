# agentfiles

What this repo is, its principles and how it's used: `README.md`. Its terms: `GLOSSARY.md`. Why it's a tool teams pull rather than a fork: `docs/adr/`. How a person changes their setup in a team repo: `core/skills/agentfiles/SKILL.md`.

- **principles**: When a change could go two ways: the README's Principles decide.
- **simple**: When changing anything here: build the simplest thing that works for a case someone has actually hit, and let every other case stop with one line naming what was expected and what was found. When a request adds machinery, do it and name the simpler option once.
- **brief**: When writing docs, comments or script output: use as few lines as it takes, and point to the README or GLOSSARY for anything they already say.
- **words**: When naming a concept: use the GLOSSARY's word; a new concept gets its entry there in the same change.
- **bash 3.2**: When editing `bin/` or an `init/` script: macOS `/bin/bash` 3.2 and its standard tools only; check any other tool at the top and stop naming it when it's missing.
- **release**: When a change alters what `agentfiles.txt` accepts or means, or the team repo's layout: bump `FORMAT` in `bin/sync` and every `agentfiles.txt` in `scaffolding/` and `templates/`, and say in `CHANGELOG.md` what a team repo must change. Every release bumps `VERSION` and gets an entry there.
