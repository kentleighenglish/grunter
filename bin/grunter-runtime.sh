#!/bin/env bash

# This is a script that is run by the grunter CLI
# It runs in the background and checks the status of the running grunt command
workingName=$1

count=0
while grunt; do
	echo -ne "$(date)"\\r
	sleep .2
done