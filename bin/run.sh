#!/bin/env bash

#PARAMETERS
# - Specify master project

parameter=()
if [ $1 ]; then
	for var in "${@:1}"; do
		parameter+=("$var");
	done
else 
	parameter="";
fi

curDir=$(dirname $0);
source $curDir/../core/gVars.sh;
source $curDir/../core/functions.sh;
source $curDir/../settings/user.sh;
source $curDir/../lib/projects.sh;

getProject ${parameter[0]} ${parameter[1]}

for i in ${!retProjectName[@]}; do
	dir=${retProjectDir[$i]}
	temp="${dir%\"}"
	temp="${temp#\"}"
	dir=$temp

	if ls $dir; then
		gnome-terminal --window --working-directory=$dir --command=$curDir/grunter-runtime.sh "${retProjectName[$i]}" &
	fi
done