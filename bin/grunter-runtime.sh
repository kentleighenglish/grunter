#!/bin/env bash

# This is a script that is run by the grunter CLI
# It runs in the background and checks the status of the running grunt command
gruntDirectory=$1;
workingName=$2;
appDir=$3;

cd "$gruntDirectory";
grunt watch --no-color > "$appDir/tmp/$$" &

lastWord="";

init;
while true; do
	word=$(tail -n 1 $appDir/tmp/$$ | sed -e 's/[" ",\.,\,].*$//');

	if [ "$word" != "" ]; then
		currentWord="$word";

		if [ "$currentWord" != "$lastWord" ]; then

			case $currentWord in
				'Completed'	| 'Waiting'	)	stateIdle
											;;
				'Running'				)	stateRunning
											;;
				'Done'					)	eventSuccess
											;;
				'Aborted'				)	eventAborted
											;;
			esac
		fi

		lastWord="$currentWord";
	fi
done

init(){

}

stateIdle(){
	
}

#If we have not exited properly
read -p "Reached the EOF without proper exit; press Ctrl+C";