#!/usr/bin/env bash

file="$1"
dir=$(dirname "$file")
feh --scale-down --zoom-step 10 --conversion-timeout 1 --start-at "$file" "$dir"
