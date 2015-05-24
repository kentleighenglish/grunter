#!/bin/sh
version="0.3"
gName="Grunter"
gDesc="Grunt Compiler Project Utility"
gAuthor="Kentleigh English"
sleepTime=.2

helpCommands=(
	"add	| a" 
	"run	| r"
	"config	| c" 
	"remove	| rm" 
	"list	| ls"
	"manage	| m"
	);
helpCommandsDesc=(
	"Add a new grunt local project"
	"Run a grunt local project"
	"Configure grunter settings" 
	"Remove a grunt local project (or child project)" 
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
	"tableNoColumns"
	"tableNoRows"
	"tableInvalidCount"
	)

#Error Type Message
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
	"Table cannot be rendered; there are no columns prepared"
	"Table cannot be rendered; there are no rows prepared"
	"Table cannot be rendered; the columns and rows are mismatched"
	)

#Error Type (i.e. Critical Error [5]: Bla bla)
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
	"Critical"
	"Critical"
	"Critical"
	)