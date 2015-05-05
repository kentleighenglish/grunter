#!/bin/bash
source $(dirname $0)/../core/gVars.sh;
source $(dirname $0)/../core/functions.sh;

while true; do
	if grep -q '\grunter' ~/.bashrc
	then
		break;
	else
		echo -e "Would you like to create a global alias for this (y/n)?  \c"; read yn;
	fi

	case $yn in	
		[Yy] )		filePath="$(dirname $0)"
					echo "alias grunter='""$filePath""'" | sed -e "s/bin/grunter/g" >> ~/.bashrc;
					break;
					;;
		[Nn] )		break;
					;;
		* )			echo;
					printStyled nrnr bbbb "Please answer" "Y" "or" "N";
					;;
	esac
done