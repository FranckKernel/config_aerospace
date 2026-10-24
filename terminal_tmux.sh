#!/bin/sh

case "$1" in
terminal)
	osascript -e 'tell application "Terminal" to do script "tmux"' -e 'tell application "Terminal" to activate'
	;;
kitty)
	kitty tmux
	;;
*)
	echo "Usage: open-tmux {terminal|kitty}" >&2
	exit 1
	;;
esac
