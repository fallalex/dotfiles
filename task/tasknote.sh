#!/usr/bin/env bash
#
# Integrate note-taking with task
# manages a taskwarrior UDA to indicate if a task has a notes file
#
# Opens $EDITOR with a file named with the task uuid
#     task note <task_id>
#
# Appends 'test note' to the task notes file
#     task note <task_id> test note
#
# Deletes the task notes file
#     task note <task_id> delete


TASKNOTEDIR=$HOME/vimwiki/tasknotes
TASKNOTEEXT=""
# TASKNOTEEXT=".md"

# Ensure input is as expected
if [[ $# -eq 0 ]]
then
    echo "id or uuid needed"
    exit
fi
TASKCOUNT=`task $1 count`
if [[ $TASKCOUNT -eq 0 ]]; then
    echo "$1 -- does not match any tasks"
    exit
fi
if [[ $TASKCOUNT != 1 ]]; then
    echo "$1 -- matches too many tasks"
    exit
fi

TASKUUID=`task $1 _uuid`
TASKPROJECT=`task _get $TASKUUID.project`
if [[ -z $TASKPROJECT ]]; then
    NOTEPATH=$TASKNOTEDIR/$TASKUUID$TASKNOTEEXT
else
    NOTEPATH=$TASKNOTEDIR/$TASKPROJECT/$TASKPROJECT$TASKNOTEEXT
fi
mkdir -p `dirname $NOTEPATH`

# Open editor, if empty file delete
if [[ $# -eq 1 ]]; then
    $EDITOR "$NOTEPATH"
    if [[ ! -s $NOTEPATH ]]; then
        rm -f $NOTEPATH
    fi
else
    echo "" >> $NOTEPATH
    echo "${@:2}" >> $NOTEPATH
fi

