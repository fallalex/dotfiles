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
#
# Expects 'uda.note' to be configured in '.taskrc'
#     task config uda.note.type string
#     task config uda.note.values yes
#     task config uda.note.label Note
#     task config uda.note.indicator N


TASKNOTEDIR=$HOME/vimwiki/tasknotes
TASKNOTEEXT=""
# TASKNOTEEXT=".md"

# Ensure input is as expected
if [[ $# -eq 0 ]]
then
    echo "task id is needed"
    exit
fi
TASKCOUNT=`task $1 count`
if [[ $TASKCOUNT -eq 0 ]]; then
    echo "'$1' is not a task id"
    exit
fi
if [[ $TASKCOUNT != 1 ]]; then
    echo "'$1' matches too many tasks"
    exit
fi

TASKUUID=`task $1 _uuid`

# Open editor, if empty file delete and unset uda.note
if [[ $# -eq 1 ]]; then
    mkdir -p $TASKNOTEDIR
    $EDITOR "$TASKNOTEDIR/$TASKUUID$TASKNOTEEXT"
    if [[ -s $TASKNOTEDIR/$TASKUUID$TASKNOTEEXT ]]; then
        task $TASKUUID mod note:yes > /dev/null 2>&1
    else
        rm -f $TASKNOTEDIR/$TASKUUID$TASKNOTEEXT
        task $TASKUUID mod note: > /dev/null 2>&1
    fi
else
    # Delete file and unset uda.note
    if [[ ${@:2} == 'delete' ]]; then
        task $TASKUUID mod note: > /dev/null 2>&1
        rm -f $TASKNOTEDIR/$TASKUUID
        echo "deleted '$TASKNOTEDIR/$TASKUUID$TASKNOTEEXT'"

    # add other options if needed
#    elif [[ ${@:2} == 'path' ]]; then

    # Append extra newline and note to task notes file
    else
        task $TASKUUID mod note:yes > /dev/null 2>&1
        echo "" >> $TASKNOTEDIR/$TASKUUID$TASKNOTEEXT
        echo "${@:2}" >> $TASKNOTEDIR/$TASKUUID$TASKNOTEEXT
    fi
fi

