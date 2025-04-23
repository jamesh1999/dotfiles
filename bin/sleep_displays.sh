#!/usr/bin/env bash

if ! playerctl --list-all | grep --invert-match "spotify" | grep --quiet "."; then
	hyprctl dispatch dpms off
elif ! playerctl status 2>/dev/null | grep --quiet "Playing"; then
	hyprctl dispatch dpms off
fi
