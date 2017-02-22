#!/bin/bash
if [[ $# == 0 ]]; then
    cat /hpgcc3/hpgcc.sh
    exit 0
fi   

# set regular uids if not run as root
if [[ $HOST_GID != 0 ]] && [[ $HOST_UID != 0 ]]; then
    groupadd -o -g $HOST_GID $HOST_GROUP
    useradd -o -m -g $HOST_GID -u $HOST_UID $HOST_USER
    echo "$HOST_USER    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    chpst -u $HOST_USER:$HOST_GROUP "$@"
else
    "$@"
fi
