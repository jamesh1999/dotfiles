#!/usr/bin/env bash

if ! playerctl --list-all | grep --invert-match "spotify" | grep --quiet "."; then
    exit 0
elif ! playerctl status 2>/dev/null | grep --quiet "Playing"; then
    exit 0
fi
exit 1
