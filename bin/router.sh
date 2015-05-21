#!/bin/env bash

#source $(dirname $0)/.pnp_vars;
#-------------------------------------------#
#---------------- FUNCTIONS ----------------#
#-------------------------------------------#
source $(dirname $0)/../core/gVars.sh;
source $(dirname $0)/../core/functions.sh;

$(dirname $0)/checkDefaults.sh;

printName;
parameter=()
if [ $2 ]; then
	for var in "${@:2}"; do
		parameter+=("$var");
	done
else 
	parameter="";
fi

if [ $1 ]; then
	cmd=$1;
else
	displayHelp;
fi

if [ $cmd ]; then
	case $cmd in
		"add" | "a" 	)	executeCommand add ${parameter[@]}
							;;
		"remove" | "rm" )	executeCommand remove ${parameter[@]}
							;;
		"config" | "c" 	)	executeCommand config ${parameter[@]}
							;;
		"list" | "ls"	)	executeCommand list ${parameter[@]}
							;;
		"manage" | "m"	)	executeCommand extend ${parameter[@]}
							;;
		*				)	displayError invalidParameter ${parameter[@]
}							;;
	esac
fi