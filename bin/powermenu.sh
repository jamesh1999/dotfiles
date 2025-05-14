#!/usr/bin/env bash

power_off=''
reboot=''
lock=''
suspend=''
log_out=''

uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostnamectl hostname`

chosen=$(printf '%s;%s;%s;%s;%s;\n' "$power_off" "$reboot" "$lock" "$suspend" \
                                   "$log_out" \
    | rofi -theme-str '@import "power.rasi"' \
           -dmenu \
           -sep ';' \
		   -p "Uptime: $uptime")

case "$chosen" in
    "$power_off")
		systemctl poweroff
        ;;

    "$reboot")
		systemctl reboot
        ;;

    "$lock")
		hyprlock
        ;;

    "$suspend")
        # Pause music and mute volume before suspending.
        #mpc --quiet pause
        #amixer set Master mute
		sleep 1 && systemctl suspend
        ;;

    "$log_out")
		uwsm stop
        ;;

    *) exit 1 ;;
esac
