#!/bin/bash
source utils.sh
DEBUG=$(get_config debug)
if [ $DEBUG -eq 1 ] 
then
    set -x
fi

TOKEN=$(cat TOKEN)
cat > CONTENT << EOF
{
 "Router":"/api/newcustomerform/submit",
 "Method":"POST",
 "Body":"{\"Field\":[{\"FieldCode\":\"disabled\",\"Content\":\"$(get_config info.college)\"},
                     {\"FieldCode\":\"disabled\",\"Content\":\"$(get_config info.grade)\"},
                     {\"FieldCode\":\"disabled\",\"Content\":\"$(get_config info.major)\"},
                     {\"FieldCode\":\"disabled\",\"Content\":\"$(get_config info.class)\"},
                     {\"FieldCode\":\"disabled\",\"Content\":\"$(get_config info.id)\"},
                     {\"FieldCode\":\"disabled\",\"Content\":\"$(get_config info.name)\"},
                     {\"FieldCode\":\"\",\"Content\":\"$(get_config info.campus)\"},
                     {\"FieldCode\":\"\",\"Content\":\"无\"},
                     {\"FieldCode\":\"\",\"Content\":\"$(get_config info.location)\"},
                     {\"FieldCode\":\"\",\"Content\":\"< 37.3℃\"},
                     {\"FieldCode\":\"\",\"Content\":\"< 37.3℃\"},
                     {\"FieldCode\":\"\",\"Content\":\"< 37.3℃\"},
                     {\"FieldCode\":\"\",\"Content\":\"否\"},
                     {\"FieldCode\":\"\",\"Content\":\"否\"},
                     {\"FieldCode\":\"\",\"Content\":\"否\"},
                     {\"FieldCode\":\"\",\"Content\":\"否\"}],
                     \"TaskCode\":\"$1\",
                     \"TemplateId\":\"87dccf2c-9572-4b0e-93e3-b72f963a6855\"}"
} 
EOF

RES=$(bash payloads/form_submit.payload $TOKEN)
# echo $RES
FEEDBACK=$(echo $RES | jq -r .FeedbackCode)

if [ $FEEDBACK -ne 0 ]
then 
    exit 1
fi