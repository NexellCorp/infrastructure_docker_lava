#!/bin/bash

set -e

CURRENT_PATH=`dirname $0`
TOOLS_PATH=`readlink -ev $CURRENT_PATH`

argc=$#
TARGET_NAME=$1

function select_submit()
{
    cd ${TOOLS_PATH}/lavatest

    if [ "s5p4418-avn-ref-tiny" == ${TARGET_NAME} ]; then
        ./submit-nexell-testjob-s5p4418-avn-ref-tiny.sh
    elif [ "s5p4418-avn-ref-qt" == ${TARGET_NAME} ]; then
        ./submit-nexell-testjob-s5p4418-avn-ref-QT.sh
    elif [ "s5p4418-avn-ref-qt" == ${TARGET_NAME} ]; then
        ./submit-nexell-testjob-s5p4418-avn-ref-qt.sh
    elif [ "s5p4418-navi-ref-tiny" == ${TARGET_NAME} ]; then
        ./submit-nexell-testjob-s5p4418-navi-ref-tiny.sh
    else
        echo "TBD"
    fi
}

select_submit
