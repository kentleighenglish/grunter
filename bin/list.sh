#!/bin/bash

curDir=$(dirname $0);
source $curDir/../core/gVars.sh;
source $curDir/../core/functions.sh;
source $curDir/../settings/user.sh;
source $curDir/../lib/projects.sh;

for projectArray in "$projects"; do
	curAlias="${projectArray#pr_}";
	projectAliases+="$curAlias"

	for project in "${!projectArray}"; do
		projectNames+="${!project[0]}"
		projectDirs+="${!project[1]}"
	done
done

echo "${projectAliases[@]}"
echo "${projectNames[@]}"
echo "${projectDirs[@]}"
echo 