#!/usr/bin/env bash
# Powerline-style statusline for Claude Code

# Colours as terminal palette numbers: 0-7 normal, 8-15 bright
SECTION_A_BG=5
SECTION_A_FG=0
SECTION_B_BG=8
SECTION_B_FG=7
SECTION_C_BG=0
SECTION_C_FG=7

# Columns kept clear at the right edge for Claude Code's own UI
RIGHT_MARGIN=4

# Read JSON input
input=$(cat)

# Powerline separator characters
SEP_LEFT=$''
SEP_RIGHT=$''

export GIT_OPTIONAL_LOCKS=0
export LC_ALL=C.UTF-8

fg_code() { printf '%d' "$(($1 < 8 ? 30 + $1 : 82 + $1))"; }
bg_code() { printf '%d' "$(($1 < 8 ? 40 + $1 : 92 + $1))"; }
BG=("$SECTION_A_BG" "$SECTION_B_BG" "$SECTION_C_BG")
FG=("$SECTION_A_FG" "$SECTION_B_FG" "$SECTION_C_FG")
ATTR=("0;1" "0" "0")
SECTION_C=2

sgr() { printf '\e[%sm' "$1"; }

visible_width() {
    printf '%s' "$1" | sed 's/\x1b\[[0-9;]*m//g' | LC_ALL=C.UTF-8 wc -m
}

# Left segments run a, b; the last separator opens the section c bar
render_left() {
    local out="" prev="" i
    for i in "${!left_segments[@]}"; do
        if [ -n "$prev" ]; then
            out+="$(sgr "0;$(fg_code "${BG[prev]}");$(bg_code "${BG[i]}")")${SEP_LEFT}"
        fi
        out+="$(sgr "${ATTR[i]};$(fg_code "${FG[i]}");$(bg_code "${BG[i]}")") ${left_segments[i]} "
        prev=$i
    done
    out+="$(sgr "0;$(fg_code "${BG[prev]}");$(bg_code "${BG[SECTION_C]}")")${SEP_LEFT}"
    printf '%s' "$out"
}

# Right segments end on section a, working back through b; the first separator closes the section c bar
render_right() {
    local out="" prev=$SECTION_C j s count=${#right_segments[@]}
    for j in "${!right_segments[@]}"; do
        s=$((count - 1 - j))
        out+="$(sgr "0;$(fg_code "${BG[s]}");$(bg_code "${BG[prev]}")")${SEP_RIGHT}"
        out+="$(sgr "${ATTR[s]};$(fg_code "${FG[s]}");$(bg_code "${BG[s]}")") ${right_segments[j]} "
        prev=$s
    done
    printf '%s%s' "$out" "$(sgr 0)"
}

# Section c bar: the branch fills the given width, truncated only when it doesn't fit
render_bar() {
    local width=$1 text="" pad
    [ -n "$branch" ] && text=" ${branch_icon} ${branch}"
    [ "${#text}" -gt "$((width - 1))" ] && text=${text:0:$((width > 1 ? width - 1 : 0))}
    pad=$((width - ${#text}))
    printf '%s%s%*s' "$(sgr "${ATTR[SECTION_C]};$(fg_code "${FG[SECTION_C]}");$(bg_code "${BG[SECTION_C]}")")" "$text" "$pad" ""
}

mapfile -t fields < <(jq -r '
    .model.display_name // "Claude",
    .workspace.repo.name // "",
    .workspace.current_dir // .cwd // "",
    .effort.level // "",
    (.context_window.used_percentage // "" | if . == "" then "" else round | tostring end)
' <<< "$input")
model=${fields[0]}
repo=${fields[1]}
cwd=${fields[2]}
effort=${fields[3]}
context_used=${fields[4]}

if [ -n "$repo" ]; then
    location=$repo
elif [ "$cwd" = "$HOME" ]; then
    location="~"
else
    location=${cwd##*/}
fi

branch=$(git -C "$cwd" symbolic-ref --quiet --short HEAD 2>/dev/null \
    || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
branch=${branch#*/}

left_segments=("$model")
[ -n "$location" ] && left_segments+=("$location")
branch_icon=$''

right_segments=()
case "$effort" in
    xhigh) effort="Extra High" ;;
    *) effort=${effort^} ;;
esac
[ -n "$effort" ] && right_segments+=("$effort")
[ -n "$context_used" ] && right_segments+=("${context_used}%")

left=$(render_left)
right=""
[ "${#right_segments[@]}" -gt 0 ] && right=$(render_right)

term_width=$(stty size < /dev/tty 2>/dev/null | cut -d' ' -f2)
term_width=${term_width:-${COLUMNS:-$(tput cols 2>/dev/null || echo 80)}}
bar_width=$((term_width - RIGHT_MARGIN - $(visible_width "$left") - $(visible_width "$right")))
[ "$bar_width" -lt 0 ] && bar_width=0

printf '%s%s%s\n' "$left" "$(render_bar "$bar_width")" "$right"
