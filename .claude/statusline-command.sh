#!/usr/bin/env bash
# Powerline-style statusline for Claude Code

# Read JSON input
input=$(cat)

# Powerline separator characters
SEP=""
SEP_THIN=""

# ANSI colour codes (for 256-colour terminals)
# Background colours
BG_BLUE="\033[48;5;33m"
BG_GREEN="\033[48;5;28m"
BG_YELLOW="\033[48;5;136m"
BG_RED="\033[48;5;160m"
BG_GREY="\033[48;5;240m"
BG_DARK_GREY="\033[48;5;236m"
BG_ORANGE="\033[48;5;166m"

# Foreground colours (for separators)
FG_BLUE="\033[38;5;33m"
FG_GREEN="\033[38;5;28m"
FG_YELLOW="\033[38;5;136m"
FG_RED="\033[38;5;160m"
FG_GREY="\033[38;5;240m"
FG_DARK_GREY="\033[38;5;236m"
FG_ORANGE="\033[38;5;166m"

# Text colours
FG_WHITE="\033[38;5;255m"
FG_BLACK="\033[38;5;16m"

RESET="\033[0m"
BOLD="\033[1m"

# Initialize output
left=""
right=""

# Segment 1: Claude mode/agent (blue background)
mode_text="Claude"
agent_name=$(echo "$input" | jq -r '.agent.name // empty')
if [ -n "$agent_name" ]; then
    mode_text="$agent_name"
fi

vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
if [ -n "$vim_mode" ]; then
    mode_text="$mode_text [$vim_mode]"
fi

left="${left}${BG_BLUE}${FG_WHITE}${BOLD} ${mode_text} ${RESET}"

# Segment 2: Directory (grey background)
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
display_dir=${current_dir/#$HOME/\~}

# Abbreviate to max depth 2
IFS='/' read -ra path_parts <<< "$display_dir"
path_count=${#path_parts[@]}

if [ "$path_count" -le 2 ]; then
    display_dir="$display_dir"
else
    display_dir=".../${path_parts[$((path_count-2))]}/${path_parts[$((path_count-1))]}"
fi

left="${left}${FG_BLUE}${BG_GREY}${SEP}${RESET}"
left="${left}${BG_GREY}${FG_WHITE} ${display_dir} ${RESET}"

# Segment 3: Git branch (colour-coded by status)
git_bg=""
git_fg=""
git_text=""

if git --git-dir="$current_dir/.git" rev-parse --git-dir >/dev/null 2>&1; then
    cd "$current_dir" 2>/dev/null || true

    ref=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

    # First 3 chars of HEAD
    head_prefix=$(printf "%.3s" "$ref")

    # If ref contains "/", take last part and abbreviate to 12 chars
    if [[ "$ref" == *"/"* ]]; then
        ref_suffix=$(basename "$ref")
        ref_suffix=$(printf "%.12s" "$ref_suffix")
        branch="${head_prefix}${ref_suffix}"
    else
        branch=$(printf "%.12s" "$ref")
    fi

    # Determine colour based on git status (skip optional locks)
    if git --no-optional-locks diff --quiet 2>/dev/null && \
       git --no-optional-locks diff --cached --quiet 2>/dev/null; then
        # Clean working tree - check ahead/behind status
        ahead_behind=$(git rev-list --left-right --count @{u}...HEAD 2>/dev/null || echo "0 0")
        behind=$(echo "$ahead_behind" | awk '{print $1}')
        ahead=$(echo "$ahead_behind" | awk '{print $2}')

        if [ "$behind" -gt 0 ] && [ "$ahead" -gt 0 ]; then
            git_bg="$BG_RED"
            git_fg="$FG_RED"
        elif [ "$behind" -gt 0 ] || [ "$ahead" -gt 0 ]; then
            git_bg="$BG_DARK_GREY"
            git_fg="$FG_DARK_GREY"
        else
            git_bg="$BG_GREEN"
            git_fg="$FG_GREEN"
        fi
    else
        git_bg="$BG_YELLOW"
        git_fg="$FG_YELLOW"
    fi

    git_text=" $branch"

    left="${left}${FG_GREY}${git_bg}${SEP}${RESET}"
    left="${left}${git_bg}${FG_BLACK}${BOLD}${git_text} ${RESET}"
    left="${left}${git_fg}${SEP}${RESET}"
else
    left="${left}${FG_GREY}${SEP}${RESET}"
fi

# Right side: Context usage
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
if [ -n "$remaining" ]; then
    # Determine colour based on remaining percentage
    if (( $(echo "$remaining < 20" | bc -l) )); then
        ctx_bg="$BG_RED"
        ctx_fg="$FG_RED"
    elif (( $(echo "$remaining < 50" | bc -l) )); then
        ctx_bg="$BG_ORANGE"
        ctx_fg="$FG_ORANGE"
    else
        ctx_bg="$BG_GREEN"
        ctx_fg="$FG_GREEN"
    fi

    # Format percentage to 1 decimal place
    remaining_fmt=$(printf "%.1f" "$remaining")

    right="${ctx_fg}${SEP}${RESET}"
    right="${right}${ctx_bg}${FG_WHITE}${BOLD} ${remaining_fmt}% ${RESET}"
fi

# Calculate padding
term_width=$(tput cols 2>/dev/null || echo 80)
# Strip ANSI codes to calculate actual display width
left_width=$(echo -e "$left" | sed 's/\x1b\[[0-9;]*m//g' | wc -c)
right_width=$(echo -e "$right" | sed 's/\x1b\[[0-9;]*m//g' | wc -c)
padding_width=$((term_width - left_width - right_width + 2))

if [ "$padding_width" -lt 0 ]; then
    padding_width=0
fi

padding=$(printf '%*s' "$padding_width" '')

# Output final statusline
printf "%b%s%b\n" "$left" "$padding" "$right"
