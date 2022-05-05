#!/bin/bash

source utils.sh
DEBUG=$(get_config debug)
if [ $DEBUG -eq 1 ] 
then
    set -x
fi

target_task="学生体温一日三检及健康台账上报"

TOKEN=$(cat TOKEN)

if [ -f LAST_TIME ]
then 
    last_task_time=$(cat LAST_TIME)
else
    last_task_time=0
fi

# find newest target 
raw_resp=$(bash payloads/get_task_list.payload $TOKEN)
tasks_count=$(echo $raw_resp | jq -r .Data.total)
for (( i=0; i < $tasks_count; i++))
do
    task=$(echo $raw_resp | jq -r .Data.list[$i])
    title=$(echo $task | jq -r .Title)
    update_time=$(date -d "$(echo $task | jq -r .UpdateDatetime)" +%s)
    if [[ $title =~ $target_task ]] && [ $update_time -gt $last_task_time ] # =~ contains
    then
        break
    fi
done

newest_task=$task
title=$(echo $newest_task | jq  -r .Title)
update_time=$(date -d "$(echo $newest_task | jq -r .UpdateDatetime)" +%s)
task_code=$(echo $newest_task | jq -r .TaskCode)

cat > CONTENT << EOF
{"Router":"/api/newcommtask/getclasstaskstudentuplist",
 "Method":"POST",
 "Body":"{\"TaskCode\":\"$task_code\"}"
}
EOF

done_count=$(bash payloads/get_task.payload $TOKEN | jq -r .Data.detail.DoneCount)

if [[ $title =~ $target_task ]] && [ $update_time -gt $last_task_time ] # =~ contains
then
    if [ $done_count -lt 5 ]
    then
        exit 4
    fi
    
    bash finish_task.sh $task_code  
    if [ $? -eq 0 ]
    then 
        echo $update_time > LAST_TIME
    fi
else 
    exit 3
fi