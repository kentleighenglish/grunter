#!/bin/env bash

curDir=$(dirname $0);
source $curDir/../core/gVars.sh;
source $curDir/../core/functions.sh;
source $curDir/../settings/user.sh;
source $curDir/../lib/projects.sh;

#Loops through elements in $projects, such as pr_d
for i in "${!projects[@]}"; do
	#Removes "pr_" prefix, and adds current alias to array
	curAlias="${projects[$i]}";
	projectAliases+=("${curAlias#pr_}")

	
	eval curMainAlias=(\${$curAlias[@]})
	#Loops through array element, such as pr_d_0
	for project in "${curMainAlias[@]}"; do
		#Fetch Project name
		eval projectNames+=\${$project[0]}

		#Fetch project directory
		eval projectDirs+=\${$project[1]}
	done
done


echo "${projectAliases[@]}"
echo "${projectNames[@]}"
echo "${projectDirs[@]}"
echo 