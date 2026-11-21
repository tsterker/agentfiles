# agentfiles-starter

What this repo is, its principles and how it's used: `README.md`. Its terms: `GLOSSARY.md`. How a team forks it and merges its changes: `FORK.md`. How to add, change or remove a skill, rule, init script, or an opt-in, off, keep or upstream line: `shared/skills/agentfiles/SKILL.md`.

- **principles**: When a change could go two ways: the README's Principles decide.
- **simple**: When changing anything here: build the simplest thing that works for a case someone has actually hit, and let every other case stop with one line naming what was expected and what was found. When a request adds machinery, do it and name the simpler option once.
- **brief**: When writing docs, comments or script output: use as few lines as it takes, and point to the README or GLOSSARY for anything they already say.
- **words**: When naming a concept: use the GLOSSARY's word; a new concept gets its entry there in the same change.
- **bash 3.2**: When editing `bin/` or an `init/` script: macOS `/bin/bash` 3.2 and its standard tools only; check any other tool at the top and stop naming it when it's missing.
