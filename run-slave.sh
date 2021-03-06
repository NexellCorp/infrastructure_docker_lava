#!/bin/bash

docker run -it --name con_lava_slave \
       -v /boot:/boot -v /lib/modules:/lib/modules -v /home/lava-slave/LAVA-TEST:/opt/share \
       -v /dev/bus/usb:/dev/bus/usb -v ~/.ssh/id_rsa_lava.pub:/home/lava/.ssh/authorized_keys:ro -v /sys/fs/cgroup:/sys/fs/cgroup \
       --device=/dev/ttyUSB0 \
       -p 2022:22 -p 5555:5555 -p 5556:5556 \
       -h lava-slave \
       --privileged \
       -e LAVA_SERVER_IP="192.168.1.18" \
       nexelldocker/lava-slave
