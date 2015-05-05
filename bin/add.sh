#!/bin/bash

source $(dirname $0)/../core/gVars.sh;
source $(dirname $0)/../core/functions.sh;
source $(dirname $0)/../settings/user.sh;

echo
divider "Step 1/3" #SET THE PROJECT ALIAS

while true; do
	projectAlias="";
	hasSpaces=0
	hasNothing=0
	hasSpecial=0
	read -r -p "Input project alias: " projectAlias;

	case $projectAlias in
		*\ * 	)
				hasSpaces=1
				;;
		""		)
				hasNothing=1
				;;
		*		)
				hasSpaces=0
				;;
	esac



	if grep -q '^[-0-9a-zA-Z]*$' <<< $projectAlias ; then 
		hasSpecial=0
	else
		hasSpecial=1
	fi

	
	if [[ "$hasNothing" == 1 ]]; then
		displayError aliasEmpty 0
	else
		if [[ "$hasSpaces" == 1 ]];then
			echo "problem"
			displayError aliasSpaces 0
		else
			if [ "$hasSpecial" == 1 ]; then
				displayError aliasSpecial 0
			else
				break;
			fi
		fi
	fi
done

echo
pause
divider "Step 2/3" #SET THE PROJECT NAME

while true; do
	echo -e "Please choose the project name: \c"; read projectName;

	if [[ ! "$projectName" == "" ]]; then
		break
	else
		echo
	fi
done

echo
pause
divider "Step 3/3" #SET THE PROJECT DIRECTORY

while true; do
	if [[ $userWorkspace ]]; then
		break
	else
		echo -e "Would you like to set a default workspace (y/n)? \c"; read yn

		case $yn in
			[Yy]	) setUserWorkspace; break;;
			[Nn]	) break;;
		esac
	fi
done