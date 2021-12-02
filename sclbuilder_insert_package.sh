#!/usr/bin/env bash

URL=$1

for REQ in `curl $URL |tr -d ' '|tr -d '\r'`
do
    NAME=`echo $REQ | awk -F'==' '{ print $1 }'`
    VERS=`echo $REQ | awk -F'==' '{ print $2 }'`
    SLUG=`echo ${NAME}___${VERS} | tr '.' '_'`
    EXTRAVAR="'{ \"slug\": \"$SLUG\", \"name\": \"$NAME\", \"version\": \"$VERS\" }'"
    ansible-playbook -i inventory sclbuilder_insert_package.yml --extra-vars $EXTRAVAR
done