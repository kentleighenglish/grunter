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

if ls $curDir/../lib/projects.sh &> /dev/null ; then
	source $curDir/../lib/projects.sh;
else
	displayError projectsFileMissing;
fi

getProject ${parameter[0]} ${parameter[1]}

curProjectNum=1;
totalProjectNum=${#retProjectName[@]};
successes=0;

for i in ${!retProjectName[@]}; do
	dir=${retProjectDir[$i]}
	temp="${dir%\"}"
	temp="${temp#\"}"
	dir=$temp

	title=${retProjectName[$i]}
	temp="${title%\"}"
	temp="${temp#\"}"
	title="$temp"

	if ls "$dir/Gruntfile.js" &> /dev/null; then
		#gnome-terminal --window --working-directory=$dir --title "Grunter: $title" --command="$curDir/grunter-runtime.sh \"$title\" \"$(dirname $curDir)\"" &
		. $curDir/grunter-runtime.sh $dir \""$title"\" $(dirname $curDir)
		printStyled cgn nn "[$curProjectNum/$totalProjectNum] " "[Success] " "Grunt project started";
		successes=$((successes+1));
	else
		printStyled crn nn "[$curProjectNum/$totalProjectNum] " "[Failure] " "Cannot start Grunt project due to missing Gruntfile.js";
	fi
	#$curDir/grunter-runtime.sh ${retProjectName[$i]} $curDir
	curProjectNum=$((curProjectNum+1));
done

#Handling the amount of successful project starts
echo;
if [ $successes -eq $totalProjectNum ]; then
	printStyled g n "All Grunt projects started";
elif [ $successes -eq 0 ]; then
	printStyled r n "All Grunt projects failed to start";
else [ $successes -gt 0 ]
	printStyled rc nn "Only $successes of $totalProjectNum Grunt projects were started";
fi
echo;

#NOTES:
# See about using ps aux -eo pid to print out management
# Also see about creating a manager process that keeps track of running grunts (If it's even necessary)
# Figure out how to check a process for output variables or status codes (something like that)