#!/usr/bin/env bash
set -euo pipefail

# Get branches marked as [gone]
to_delete=$(git branch -vv | grep 'gone\]' | awk '{print $1}')

# If no branches to delete
if [[ -z "$to_delete" ]]; then
    echo "No local branches to delete."
else
    count=$(echo "$to_delete" | wc -l | tr -d ' ')
    echo "Deleting $count branches..."
    echo "$to_delete" | xargs -n 1 git branch -D
fi
