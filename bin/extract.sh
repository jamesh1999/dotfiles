#!/usr/bin/env bash

if [ -f "$1" ] ; then
  case "$1" in
    *.tar*|*.tgz|*.tbz2)  tar xf "$1"     ;;
    *.bz2)                bunzip2 "$1"    ;;
    *.gz)                 gunzip "$1"     ;;
    *.xz)                 unxz "$1"       ;;
    *.zst)                unzstd "$1"     ;;
    *.rar)                unrar x "$1"    ;;
    *.zip)                unzip "$1"      ;;
    *.7z)                 7z x "$1"       ;;
    *.deb)                dpkg -x "$1" .  ;;
    *)                    echo "'$1' cannot be extracted" ;;
  esac
else
  echo "'$1' is not a valid file"
fi

