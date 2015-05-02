#!/bin/bash

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
	printStyled rrny bnnb	 "$gDesc" "(version $version)" "by" "$gAuthor";
	echo;
}

displayError(){
	echo "error";
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