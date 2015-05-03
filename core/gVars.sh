#!/bin/sh
version="0.1"
gName="Grunter"
gDesc="Grunt Compiler Utility"
gAuthor="Kentleigh English"
sleepTime=.2

helpCommands=(
	"add" 
	"config" 
	"remove" 
	"list"
	);
helpCommandsDesc=(
	"Add a new grunt local" 
	"Configure grunter settings" 
	"Remove a grunt local" 
	"List all currently added grunt locals"
	);

#Error Type Arrays
invalidCommandArray=("Invalid Command Passed" 0);
invalidParameterArray=("Parameter is invalid" 0);


#Error Types
errorType["invalidCommand"]=invalidCommandArray;
errorType["invalidParameter"]=invalidParameterArray;