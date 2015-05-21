#!/bin/env bash

curDir=$(dirname $0);
source $curDir/../core/gVars.sh;
source $curDir/../core/functions.sh;
source $curDir/../settings/user.sh;
source $curDir/../lib/projects.sh;

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
				echo;
			fi
		fi
	fi

	aliasVar="pr_$projectAlias"
	if [ "${!aliasVar}" ]; then
		echo "This alias already exists"
		echo -e "Would you like to add this project to the existing alias (y/n)? \c"; read yn;

		case $yn in
			[Yy]	)	unique=2; break;;
			[Nn]	)	unique=0;;
			*		)	echo 'Please answer with "Y" or "N" only.'; echo;;
		esac
	else
		unique=1;
		break;
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
		break;
	else
		echo -e "Would you like to set a default workspace (y/n)? \c"; read yn

		case $yn in
			[Yy]	) setUserWorkspace; break;;
			[Nn]	) break;;
		esac
	fi
done

while true;do
	echo "Please input the folder location of the project Gruntfile.js:";
	if [ ! $tempWorkspace ]; then
		read -e -i "$userWorkspace" projectDirectory;
	else
		read -e -i "$tempWorkspace" projectDirectory;
	fi

	if ls "$projectDirectory""Gruntfile.js" 2>/dev/null ; then
		break;
	else
		displayError directoryNoGrunt
		tempWorkspace=$projectDirectory
	fi

done

echo "Adding data..."
submitProject "$projectAlias" "$projectName" "$projectDirectory" "$unique"