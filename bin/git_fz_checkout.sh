#!/usr/bin/env bash
set -euo pipefail

tmpfifo=$(mktemp -u)
mkfifo "$tmpfifo"
trap 'rm -f "$tmpfifo"' EXIT

# Local branches first (fast)
git branch --format='%(refname:short)' >"$tmpfifo" &

# Remote branches after fetch (slower)
(
  git fetch --quiet origin >/dev/null 2>&1
  git for-each-ref --format='%(refname)' refs/remotes \
    | sed 's#^refs/remotes/[^/]*/##'
) >>"$tmpfifo" &

# Read and deduplicate
branch=$(awk '!seen[$0]++ { print; fflush() }' <"$tmpfifo" | fzf)
[ -z "$branch" ] && exit 0

git checkout "$branch" 2>/dev/null

