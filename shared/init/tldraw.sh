#!/bin/bash
# tldraw office installs its agent skill, subagents and hooks itself, and keep.txt leaves them be.
# This checks it did. Don't use tldraw? Put tldraw in your off.txt.
[ -d "/Applications/tldraw office.app" ] || exit 0
[ ! -f "$HOME/Library/Application Support/tldraw/agent-skills.json" ] || exit 0
echo "tldraw: open tldraw office, choose Develop > Install Agent Skills, then run bin/sync again" >&2
exit 1
