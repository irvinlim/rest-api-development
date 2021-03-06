#!/bin/bash

# Check if taven is installed
if ! hash tavern-ci 2>/dev/null; then
    echo -e 'tavern is not installed.'
    echo -e 'Please install by it by typing sudo pip install tavern'
    exit 0
else
    USER=`echo $RANDOM | md5sum | awk '{ print $1 }'`
    PASS=`echo $USER | md5sum | awk '{ print $1 }'`

    # Randomise username and password in our test variable file
    sed -i '/  username: /c\  username: '$USER'' includes.yaml
    sed -i '/  password: /c\  password: '$PASS'' includes.yaml

    # Setup user-defined python modules
    LOC=pwd
    export PYTHONPATH=${PYTHONPATH}:${LOC}

    echo -e '\n\nTESTING USERS ENDPOINT\n'
    tavern-ci --stdout users_test.yaml

    echo -e '\n\nTESTING DIARY ENDPOINT\n'
    tavern-ci --stdout diary_test.yaml

    echo -e '\n\nTESTING COMPLETED\n'    
fi