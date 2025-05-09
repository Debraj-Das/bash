#!/usr/bin/env bash

# Set -euo pipefail:  Exit immediately if a command exits with a non-zero status.
# -e: Exit if a command exits with a non-zero status.
# -u: Treat unset variables as an error.
# -o pipefail:  If a command in a pipeline fails, the whole pipeline fails.
set -euo pipefail

# song=~/Music/alarm.mp3

# mpg123 -q --loop -1 $song

if [ $# -lt 1 ]; then
	echo "Time needed"
	echo "Useage: $0 <seconds>"
	echo "Example: $0 2"
	exit 0
fi

function main() {
	s=1
	start=$SECONDS
	time="$1"
	alarm="$2"
	loop="$3"

	echo "Timer started..."
	while [ $s -gt 0 ]; do
		s="$((time - (SECONDS - start)))"
		echo -ne "\r                   \r"

		min=$(("$s" / 60))
		sec=$(("$s" % 60))

		if [[ min -eq 0 ]]; then
			echo -ne "\r$s seconds left"
		else
			echo -ne "\r$min mins $sec secs left"
		fi

		sleep 1
	done

	echo -e "\nTimes Up"

	if [ -f "$alarm" ] && command -v mpg123 >/dev/null 2>&1; then
		mpg123 -q --loop "$loop" "$alarm"
	fi

	exit 0
}

alarm="$HOME/.config/bash/assets/audio/alarm.mp3"

time="$1"

loop=-1
if [[ $# -ge 2 ]] && [[ "$2" =~ ^[0-9]+$ ]]; then
	loop="$2"
fi

main "$time" "$alarm" "$loop"

exit 0
