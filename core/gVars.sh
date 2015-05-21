#!/bin/sh
version="0.1"
gName="Grunter"
gDesc="Grunt Compiler Project Utility"
gAuthor="Kentleigh English"
sleepTime=.2

helpCommands=(
	"add	| a" 
	"config	| c" 
	"remove	| rm" 
	"list	| ls"
	"manage	| m"
	);
helpCommandsDesc=(
	"Add a new grunt local" 
	"Configure grunter settings" 
	"Remove a grunt local" 
	"List all currently added grunt locals"
	"List and stop currently running grunt compilers"
	);

#Error Type Names
errorType=(
	"invalidCommand" 
	"invalidParameter"
	"aliasSpaces"
	"aliasSpecial"
	"aliasUnique"
	"aliasEmpty"
	"nameEmpty"
	"directoryNotexist"
	"directoryNoGrunt"
	)

errorTypeMsg=(
	"Invalid Command Passed" 
	"Given parameter is invalid"
	"Alias must not have spaces; plain letters/numbers only"
	"Alias must not have special characters; plain letters/numbers only"
	"Alias already exists (Use grunter list to see existing aliases)"
	"The project alias cannot be empty"
	"The project name cannot be empty"
	"That directory does not exist"
	"No local Gruntfile.js found in that directory"
	)

errorTypePriority=(
	"Minor" 
	"Minor"
	"Input"
	"Input"
	"Input"
	"Input"
	"Input"
	"Input"
	"Input"
	)