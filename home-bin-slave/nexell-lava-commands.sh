#!/bin/bash

set -e

CURRENT_PATH=`dirname $0`
argc=$#

COMMAND_TYPE=$1
DOWNLOAD_DIR_NAME=$2
#USB_BUS_NUM=0

function run_command()
{
    local command=${COMMAND_TYPE}
    local path=${DOWNLOAD_DIR_NAME}
    #local usb_num=${USB_BUS_NUM}

    if [ $command == 'reboot-bootloader' ]; then
	echo " " > /dev/ttyUSB0; sleep 1
	echo " " > /dev/ttyUSB0; sleep 1
        echo "root" > /dev/ttyUSB0; sleep 3
        echo "root" > /dev/ttyUSB0; sleep 3
        echo "reboot" > /dev/ttyUSB0; sleep 10

        /opt/share/$path/tools/standalone-uboot-by-usb-download.sh
        for ((i=0;i<5;i++)); do
            sleep 0.5
            echo " " > /dev/ttyUSB0
        done

        sleep 2

        echo "fast 0" > /dev/ttyUSB0; sleep 1
        echo "OKAY"
	echo "======================================="
        echo "Success, usb-download!"
        echo "======================================="

    elif [ $command == 'fastboot-download' ]; then
        /opt/share/$path/tools/standalone-fastboot-download.sh

        sleep 3

        echo "OKAY"
	echo "======================================="
        echo "Success, fastboot-download!"
        echo "======================================="

    elif [ $command == 'running' ]; then
        echo " " > /dev/ttyUSB0
        echo "OKAY"
        echo "======================================="
        echo "Success, Nexell Ready for Test!"
        echo "======================================="

    elif [ $command == 'boot-on-uboot' ]; then
	echo " " > /dev/ttyUSB0; sleep 15
        echo "boot" > /dev/ttyUSB0; sleep 10
	echo "root" > /dev/ttyUSB0; sleep 3
        echo "root" > /dev/ttyUSB0; sleep 3
        echo "root" > /dev/ttyUSB0; sleep 3
	echo "/usr/bin/start_adbd.sh" > /dev/ttyUSB0; sleep 2
        echo "/usr/bin/start_adbd.sh" > /dev/ttyUSB0; sleep 2
	echo " " > /dev/ttyUSB0
	echo "OKAY"
        echo "======================================="
        echo "Success, reset after fastboot download!"
        echo "======================================="

    elif [ $command == 'run-uboot-by-usb' ]; then
        run_uboot_by_usb_download $path
    else
        echo "finished"
    fi
}

function run_uboot_by_usb_download()
{
    /opt/share/$1/tools/standalone-uboot-by-usb-download.sh
    for ((i=0;i<5;i++)); do
        sleep 0.5
        echo " " > /dev/ttyUSB0
    done
    echo "OKAY"
    echo "==================================="
    echo "Success, Nexell run-uboot download!"
    echo "==================================="

}

function run_fastboot_download()
{
    /opt/share/$1/tools/standalone-fastboot-download.sh; sleep 3
    echo "OKAY"
    echo "=================================="
    echo "Success, Nexell Fastboot download!"
    echo "=================================="
}

run_command
