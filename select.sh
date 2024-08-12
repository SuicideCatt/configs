#!/usr/bin/bash

. ./log.sh

link_file()
{
	if [ ! -f "$2" ]; then ln -s "$PWD/$1" "$2"; ldone; else lskip; fi;
}
link_dir()
{
	if [ ! -d "$2" ]; then ln -s "$PWD/$1" "$2"; ldone; else lskip; fi;
}

DEV=$1

llinking "Hyprland config for $DEV"
rm hypr/selected &> /dev/null
link_dir "hypr/$DEV" "hypr/selected"
