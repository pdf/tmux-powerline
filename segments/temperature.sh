#!/usr/bin/env bash
unit="c"

case $(uname -s) in
    "Linux")
		TEMPERATURE=/sys/class/thermal/thermal_zone0/temp
		if [ -r $TEMPERATURE ]; then
			degrees=$((`cat ${TEMPERATURE}` / 1000))
		fi
		;;
	*)
		exit
		;;
esac

if [ -n "$degrees" ] ; then
	if [ "$unit" == "k" ] ; then
		degrees=$(echo "${degrees} + 273.15" | bc)
	fi
	unit_upper=$(echo "$unit" | tr '[cfk]' '[CFK]')
	echo "♨ ${degrees}°${unit_upper} "
fi
