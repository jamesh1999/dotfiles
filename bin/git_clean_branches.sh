#!/usr/bin/env bash
set -euo pipefail

# Get branches marked as [gone]
to_delete=$(git branch -vv | grep 'gone\]' | awk '{print $1}')

# If no branches to delete
if [[ -z "$to_delete" ]]; then
    echo "No local branches to delete."
else
    echo "$to_delete" | fzf --multi --bind "load:toggle-all" --preview "git log --oneline --decorate {}"  | xargs -r git branch -D
fi
