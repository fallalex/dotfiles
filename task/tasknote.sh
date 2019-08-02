#!/usr/bin/env bash

TASKNOTEDIR=$HOME

if [[ $# -eq 0 ]]
then
    echo "task id is needed"
elif [[ $# -eq 1 ]]
then
    TASKUUID=`task $1 _uuid`
    nvim $TASKNOTEDIR/$TASKUUID
else
    TASKUUID=`task $1 _uuid`
    echo "" >> $TASKNOTEDIR/$TASKUUID
    echo "${@:2}" >> $TASKNOTEDIR/$TASKUUID
fi

