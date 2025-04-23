#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | rofi -dmenu -i | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                sleep 1 && systemctl $op
                ;;
		lock)
				hyprlock
				;;
        logout)
                uwsm stop
                ;;
esac
