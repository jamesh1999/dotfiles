#!/usr/bin/env bash

CREDS=c2lsaWNvbjpicmFtYmxl
OUTPUT_DIR=~/Pictures/Screenshots/$(date +"%Y-%m")
OUTPUT_FILE=$(date +"%Y-%m-%d_%H-%M-%S").png

while getopts "u" flag; do
	case $flag in
		u)
		upload=true
		;;
	esac
done

hyprpicker -r -z &
sleep .3

rect=$(slurp)
sleep .3
killall hyprpicker
if [[ ! $rect ]]; then
	exit
fi

mkdir -p $OUTPUT_DIR
echo $rect | grim -g - "$OUTPUT_DIR/$OUTPUT_FILE"
wl-copy < "$OUTPUT_DIR/$OUTPUT_FILE"


if [[ $upload ]]; then
	url=$(curl -X POST \
		-H "Authorization: Basic $CREDS" \
		-H "Content-Type: application/octet-stream" \
		-H "title: $OUTPUT_FILE" \
		--data-binary "@$OUTPUT_DIR/$OUTPUT_FILE" \
		https://pony.cx/upload)
	wl-copy $url
	notify-send -i "$OUTPUT_DIR/$OUTPUT_FILE" "Screenshot Uploaded" $url
fi
