#!/bin/env bash

curDir=$(dirname $0);
source $curDir/../core/gVars.sh;
source $curDir/../core/functions.sh;
source $curDir/../settings/user.sh;
source $curDir/../lib/projects.sh;

#Loops through elements in $projects, such as pr_d
count=0
for i in "${!projects[@]}"; do
	#Removes "pr_" prefix, and adds current alias to array
	curAlias="${projects[$i]}";
	
	eval curMainAlias=(\${$curAlias[@]})
	#Loops through array element, such as pr_d_0
	for project in "${curMainAlias[@]}"; do
		projectAliases[$count]="${curAlias#pr_}"
		subProjects[$count]="${project#pr_}"
		
		#Fetch Project name
		eval name=\${$project[0]}
		projectNames[$count]=$name


		#Fetch project directory
		eval projectDirs[$count]=\${$project[1]}

		count=$(( count + 1 ))
	done
done

#Encapsulating project names in double quotes

echo 

#Preparing table view
prepTableCols 'Project Aliases' 'Project Sub-locals' 'Project Names' 'Project Directories'
prepTableRow 0 "${projectAliases[@]}"
prepTableRow 1 "${subProjects[@]}"
prepTableRow 2 "${projectNames[@]}"
prepTableRow 3 "${projectDirs[@]}"
#Render table view
renderTable "|" "-"