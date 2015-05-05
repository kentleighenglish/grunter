#!/bin/bash

#source $(dirname $0)/.pnp_vars;
#-------------------------------------------#
#---------------- FUNCTIONS ----------------#
#-------------------------------------------#
source $(dirname $0)/../core/gVars.sh;
source $(dirname $0)/../core/functions.sh;

$(dirname $0)/checkDefaults.sh;

printName;

if [ $1 ]; then
	cmd=$1;
else
	displayHelp;
fi

if [ $cmd ]; then
	case $cmd in
		"add" | "a" 	)	executeCommand add
							;;
		"remove" | "rm" )	executeCommand remove
							;;
		"config" | "c" 	)	executeCommand config
							;;
		"list" | "ls"	)	executeCommand list
							;;
		*				)	displayError invalidParameter
							;;
	esac
fi