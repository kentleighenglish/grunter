#!/bin/env bash
source $(dirname $0)/../settings/user.sh;
settingsDir=$(dirname $0)/../settings/user.sh;

#Echo Colours
colour_r=31m; #red
colour_g=32m; #green
colour_y=33m; #yellow
colour_b=34m; #blue
colour_p=35m; #purple
colour_c=36m; #cyan
colour_n=0m;  #none

printStyled(){
	colourVar=$1;
	bold=$2;
	esc="\e["
	output=();
	styledOutput=();

	for var in "${@:3}"; do
		output+=("$var");
	done

	for key in "${!output[@]}"; do
		colourInput="${colourVar:$key:1}";
		colourVarName="colour_$colourInput"
		colour="""${!colourVarName}";

		boldInput="${bold:$key:1}";
		if [[ "$boldInput" == "b" ]]; then
			boldStyled="1;";
		else
			boldStyled='0';
		fi

		styledOutput+="$esc$boldStyled$colour""${output[$key]}""$esc$colour_n ";
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
		printStyled cn nn "	${helpCommands[$i]}" "			${helpCommandsDesc[$i]}"
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

submitProject(){
	chosenAlias=$1
	chosenName=$2
	chosenDir=$3
	
	
	arrayName="pr_$chosenAlias"
	#If the project alias already exists
	if [[ "$4" == 2 ]]; then

		#Checking to see hwo many projects are under the alias previously
		#newNum=$((existingNum+1))
		eval existingNum=(\${#$arrayName[@]})

		#Printing out the values to projects.sh
		echo "$arrayName+=""('$arrayName""_$existingNum')" >> $(dirname $0)/../lib/projects.sh
		echo "$arrayName""_$existingNum=('$2' '\"$3\"')" >> $(dirname $0)/../lib/projects.sh
		echo >> $(dirname $0)/../lib/projects.sh
	
	#if the project did not exist...
	else
		if [[ "$4" == 1 ]]; then
			existingNum=0

			echo "projects+=('$arrayName')" >> $(dirname $0)/../lib/projects.sh
			echo "$arrayName+=""('$arrayName""_$existingNum')" >> $(dirname $0)/../lib/projects.sh
			echo "$arrayName""_$existingNum=('$2' '\"$3\"')" >> $(dirname $0)/../lib/projects.sh
		fi
	fi
	
}

#Returns the aliases
getAliases(){
	if [ "$1" ]; then
		aliasVar="pr_$1"
		echo $aliasVar
	else
		echo
	fi

}

getProjects(){
	echo
}

#Prepare table columns
prepTableCols() {
	inputArray=()
	columnsPrepared=0;

	count=0
	while true; do
		for i in $1; do
			columnArray[$count]="$1"
			#inputArray[$i]=$i;
			
			shift
			count=$(( count + 1))
		done

		if [ ! "$1" ]; then
			break
		fi
	done

	if [ "$columnArray" ]; then
		columnCount="$count";
		columnsPrepared=1;
	fi
}

prepTableRow() {
	rowIndex=$1
	shift
	
	#eval rowArray_$rowIndex=();

	if [ "$rowsPreparedPrev" ]; then
		rowsPrepared=$rowsPreparedPrev
	else
		rowsPrepared=0
	fi


	count=0
	while true; do
		for i in $1; do
			eval rowArray_$rowIndex[$count]="$1"
			
			shift
			count=$(( count + 1))
		done

		if [ ! "$1" ]; then
			rowVar="rowArray_$rowIndex";
			break
		fi
	done

	if [ "$rowVar" ]; then
		rowsPrepared=$(( $rowsPrepared + 1 ));
		rowsPreparedPrev=$rowsPrepared
	fi
}

getLongest() {
	if [ ! "$longest" ]; then
		longest=0
	fi

	length=${#1}
	echo $length
}

renderTable(){
	#Checking if all is good to go
	if [[ ! "$columnsPrepared" == 1 ]]; then
		displayError tableNoColumns
	else
		if [[ "$rowsPrepared" == 0 ]]; then
			displayError tableNoRows
		else
			if [ "$columnCount" -ne "$rowsPrepared" ]; then
				displayError tableInvalidCount
			fi
		fi
	fi

	#Init
	vDiv=$1
	hDiv=$2
	rowsArray=()
	divider=":$vDiv:"

	for i in ${!rowArray_0[@]}; do
		row=()

		cols=()
		colNum=0
		while [[ $colNum -lt "$columnCount" ]]; do
			eval var=\${rowArray_$colNum[$i]}

			while [ ${#var} -gt 85 ]; do
				#rem=$(( ${#var} - 100 ))
				var=${var%?}
			done

			row+=$var
			
			#eval getLongest \${rowArray_$colNum[$i]}

			#Checking to see whether it's the last element in array
			colMax=$(( $colNum + 1 ))
			if [[ ! $colMax == "$columnCount" ]];then
				row+="$divider"
			else
				row+="\n"
			fi

			colNum=$(( colNum + 1 ))

		done

		rowsArray[$i]=$row
	done

	colNum=0
	rowNum=0
	while [[ $colNum -lt "$columnCount" ]]; do
		for i in eval \${!rowArray_$rowNum[@]}; do
			echo $i
		done

		colNum=$(( colNum + 1 ))
	done

	#Reformatting column headers with dividers
	for i in ${!columnArray[@]}; do
		newColumnArray+=${columnArray[$i]}

		v=$(( i + 1 ))
		if [[ ! $v == ${#columnArray[@]} ]];then
			newColumnArray+=$divider
		fi
	done

	#Table header
	headers=$newColumnArray
	rows=${rowsArray[@]}
	
	dividers="---------------- :|: ----------------------- :|: ------------------------------ :|: ---------------------------------------------------------------------------------------"
	
	#separator
	sep=":"

	outputTable="$dividers\n$headers\n$dividers\n$rows\n$dividers"

	echo -ne $outputTable | column -t -s "$sep"

}