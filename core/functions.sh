#!/bin/bash

source $(dirname $0)/../settings/user.sh;
settingsDir=$(dirname $0)/../settings/user.sh;

#Echo Colours
r=31m; #red
g=32m; #green
y=33m; #yellow
b=34m; #blue
p=35m; #purple
c=36m; #cyan
n=0m;  #none

printStyled(){
	colorVar=$1;
	bold=$2;
	esc="\e["
	output=();
	styledOutput=();

	for var in "${@:3}"; do
		output+=("$var");
	done

	for key in "${!output[@]}"; do
		colorInput="${colorVar:$key:1}";
		color="${!colorInput}";

		boldInput="${bold:$key:1}";
		if [[ "$boldInput" == "b" ]]; then
			boldStyled="1;";
		else
			boldStyled='';
		fi

		styledOutput+="$esc$boldStyled$color""${output[$key]}""$esc$n ";
	done

	echo -e "${styledOutput[@]}";
}

#Global Functions
printName(){
	printStyled nbnb bnnn	 "$gDesc" "(version $version)" "by" "$gAuthor";
}

displayError(){
	t=$1

	if [[ $2 ]]; then
		showHelp=$2
	else
		showHelp=1
	fi

	if [[ $t != "" ]]; then
		for key in "${!errorType[@]}"; do

			if [[ "${errorType[$key]}" == "$t" ]]; then
					printStyled ccr bbn "${errorTypePriority[$key]}" "Error [$key]:" "${errorTypeMsg[$key]}";
					echo
			fi
		done
	fi

	if [[ $showhelp == 1 ]]; then
		displayHelp
	fi
}

displayHelp(){
	printStyled b n "Usage:"
	printStyled c n "	grunter [option] [parameter]"
	echo
	printStyled b n "Available Commands:"
	for i in "${!helpCommands[@]}"; do
		printStyled cn nn "	${helpCommands[$i]}" "				${helpCommandsDesc[$i]}"
	done
}

executeCommand(){
	file=$1

	$(dirname $0)/"$file.sh"
}

divider(){
	echoString=$1
	num=20
	str="-"
	v=$(printf "%-${num}s" "$str")
	liner="${v// /-}"

	empty="$(echo "$echoString" | sed 's/./-/g')";
	
	echo "$liner $echoString $liner"
	echo
}

pause(){
	sleep $sleepTime;
}

setUserWorkspace(){
	echo
	echo "Please input your new workspace directory:"
	
	if [ $userWorkspace ]; then
		read -i "$userWorkspace" -e tempWorkspace;
	else
		read -e tempWorkspace;
	fi
	echo
	submitUserSetting "userWorkspace" "$tempWorkspace" "Workspace set" 0
}

submitUserSetting(){
	varName="$1"
	varValue="$2"
	varIgnore="$4"

	if [ "${!varName}" != "" ]
	then
		if [[ "$4" == 0 ]]; then
			while true; do
				read -p "Overwrite previous setting? " yn
				case $yn in
					[Yy]* ) sudo sed -i '/'"$varName"'/ c\'"$varName=$varValue" "$settingsDir"
							echo "$3"; break;;
					[Nn]* ) break
							return false
							;;
					* ) echo "Please answer Y (Yes) or N (No).";;
				esac
			done
		else
			sudo sed -i '/'"$varName"'/ c\'"$varName=$varValue" "$settingsDir"

			#grep 's/$varName c\/$varName=$varValue' "$settingsDir";
		fi
	else
		echo "$varName=$varValue" >> "$settingsDir";
		echo "$3";
	fi
}