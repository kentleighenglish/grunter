#!/bin/env bash

curDir=$(dirname $0);
source $curDir/../core/gVars.sh;
source $curDir/../core/functions.sh;

rm $curDir/../tmp/* &> /dev/null;

kill -9 $(pidof grunter-runtime);

printStyled g n "Temp files cleared, all projects stopped";