#!/bin/bash
# make the working dir is current
cd $(dirname $(readlink -f "$0"))
source utils.sh

DEBUG=$(get_config debug)
if [ $DEBUG -eq 1 ] 
then
    set -x
fi


bash get_token.sh
if [ $? -ne 0 ]
then 
    echo "获取Token错误"
    exit 2
fi

bash get_task_list.sh
STATUS=$?
if [ $STATUS -ne 0 ]
then
    echo -n "填报错误"
    if [ $STATUS == 3 ]
    then 
        echo "(今天已经填过了)"
        exit 3
    fi
    if [ $STATUS == 4 ]
    then
        echo "(人数还不够)"
        exit 4
    fi 
fi