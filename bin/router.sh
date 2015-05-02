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
	parameter=$1;
else
	displayHelp;
fi