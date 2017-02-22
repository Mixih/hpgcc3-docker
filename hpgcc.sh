#!/bin/env bash
# grab current user name info

VERSION="0.5b1"
HOSTUID=$(id -u)
HOSTGID=$(id -g)
HOSTUSER=$(id -un)
HOSTGROUP=$(id -gn)

printHelp() {
    echo "HPGCC3 cross compiler assitant script version $VERSION"
    echo "NOTE: Images are non-persistant and will not keep any data across runs."
    echo "USAGE: hpgcc.sh [special options] [command to run in image]"
    echo "invoke with a command to run the command in the cross compiler docker image"
    echo "all commands are run in current working dir\n"
    echo "Common tools:"
    echo "   * make: GNU make"
    echo "   * arm-eabi-none-** : arm cross-compile tools\n"
    echo "Special options for this script:"
    echo "   --script -s"
    echo "      output this scipt to stdout"
    echo "   --make -m"
    echo "      automake the current dir with default options"
}


case $1 in

    --help|-h)
        printHelp
        exit 0
        ;;

    --make|-m)
        SOPTS="bash -c /hpgcc3/amake.sh"
        ;;

    --script|-s)
        SOPTS="cat /hpgcc3/hpgcc.sh"
        ;;

    '')
        printHelp
        exit 0
        ;;

    *)
        ;;

esac

CONTAINER_NAME=hpgcc3_$RANDOM
if ! [[ $SOPTS ]]; then
    docker run --name $CONTAINER_NAME -it -v $PWD:/work \
            -e HOST_UID=$HOSTUID -e HOST_GID=$HOSTGID \
            -e HOST_USER=$HOSTUSER -e HOST_GROUP=$HOSTGROUP \
            hpgcc "$@"
else
    docker run --name $CONTAINER_NAME -it -v $PWD:/work \
            -e HOST_UID=$HOSTUID -e HOST_GID=$HOSTGID \
            -e HOST_USER=$HOSTUSER -e HOST_GROUP=$HOSTGROUP \
            hpgcc $SOPTS
fi
RUN_EXIT_CODE=$?
docker rm $CONTAINER_NAME
exit $RUN_EXIT_CODE
