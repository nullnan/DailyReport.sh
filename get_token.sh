#!/bin/bash
source utils.sh

DEBUG=$(get_config debug)
if [ $DEBUG -eq 1 ] 
then
    set -x
fi

PHONE=$(get_config phone)
PASSWORD=$(get_config password)

LOGIN_TMP="{\"LoginModel\":1,\"Service\":\"ANT\",\"UserName\":\"$PHONE\"}"

USERNAME=$(_base64 $LOGIN_TMP)
H_PASSWORD=$(_md5 $PASSWORD)

RES=$(bash payloads/get_token.payload $USERNAME $H_PASSWORD)

echo "ACKEY_"$(echo $RES | jq -r .access_token) > TOKEN