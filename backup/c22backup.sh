#!/bin/sh
## c22backup.sh
## Version 0.1
## Darin Webb

# A POSIX variable
OPTIND=1		 # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file="./c22backup.log"
verbose=0
mode=0

while getopts "h?vbrcl:" opt; do
	case "$opt" in
	h|\?)
		show_help
		exit 0
		;;
	v)
		verbose=1
		;;
	b)	# Backup Mode
		mode=1
		;;
	r)	# Restore Mode
		mode=2
		;;
	c)	# Collapse Mode
		mode=3
		;;
	l)	# Set Log File
		output_file=$OPTARG
		;;
	:)	
		echo "Option -$OPTARG requires an argument." >&2
		;;
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

echo "verbose=$verbose, output_file='$output_file', mode='$mode', Leftovers: $@"

echo.
for i
do
  echo "-->$i"
done

# End of file