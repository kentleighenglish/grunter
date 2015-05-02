#!/bin/sh

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

	color="$n";
	# echo -e "$esc$color""$output""$esc$n";

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
	printStyled cyg bbb "[ $gName ]" "$gDesc" "(version $version)";
	echo;
}

displayError(){
	echo "error";
}

displayHelp(){
	echo "";
}