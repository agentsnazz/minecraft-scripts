#!/bin/sh
## c22backup.sh
## Version 0.2
## Darin Webb

# A POSIX variable
OPTIND=1		 # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file="./c22backup.log"
verbose=1		# Verbose option locked to 1 during development.
mode=0
use_screen=0

while getopts "h?vbrcl:s:d:" opt; do
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
	s)	# Set Screen
		use_screen=1
		screen_name=$OPTARG
		;;
	d)	# Set data to backup
		data_location=$OPTARG
		;;
	:)	
		echo "Option -$OPTARG requires an argument." >&2
		;;
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

if ($verbose); then
	echo "verbose=$verbose, output_file='$output_file', mode='$mode', Leftovers: $@"
fi

# End of file