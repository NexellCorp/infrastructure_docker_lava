#!/bin/bash
#Create a qemu devices and add them to lava-server

lava-server manage pipeline-worker --hostname lava-slave

curdir="$(dirname "$(readlink -f "$0")")"
if [ -f "${curdir}/lava-credentials.txt" ]; then
  . "${curdir}"/lava-credentials.txt
fi

#LAVA-SERVER
lavaurl=http://192.168.1.18
tools_path="${tools_path:-/home/lava/bin}"
hostn=$(hostname)

#obtain the csrf token
data=$(curl -s -c ${tools_path}/cookies.txt $lavaurl/accounts/login/); tail ${tools_path}/cookies.txt

#login
csrf="csrfmiddlewaretoken="$(grep csrftoken ${tools_path}/cookies.txt | cut -d$'\t' -f 7); echo "$csrf"
login=$csrf\&username=$adminuser\&password=$adminpass; echo $login
curl -b ${tools_path}/cookies.txt -c ${tools_path}/cookies.txt -d $login -X POST $lavaurl/admin/login/

#create lava-slave
csrf="csrfmiddlewaretoken="$(grep csrftoken ${tools_path}/cookies.txt | cut -d$'\t' -f 7); echo "$csrf"
work=$csrf\&hostname="lava-slave"; echo $login
curl -b ${tools_path}/cookies.txt -c ${tools_path}/cookies.txt -d $work -X POST $lavaurl/admin/lava_scheduler_app/worker/add/

mkdir -p /etc/dispatcher-config/devices

# s5p4418-navi-ref
devicename=s5p4418-navi-ref
devicetype=s5p4418-navi-type
# Add device type
csrf="csrfmiddlewaretoken="$(cat  ${tools_path}/cookies.txt | grep csrftoken | cut -d$'\t' -f 7)
createdevicetype=$csrf\&name=$devicetype\&display=on\&health_frequency=24\&_save=Save\&health_denominator=0
curl -b ${tools_path}/cookies.txt -c ${tools_path}/cookies.txt -d $createdevicetype -X POST $lavaurl/admin/lava_scheduler_app/devicetype/add/
## Add device
csrf="csrfmiddlewaretoken="$(cat  ${tools_path}/cookies.txt | grep csrftoken | cut -d$'\t' -f 7)
createdevice=$csrf\&hostname=$devicename\&device_type=$devicetype\&device_version=1\&status=1\&health_status=0\&is_pipeline="on"\&worker_host=lava-slave
curl -b ${tools_path}/cookies.txt -c ${tools_path}/cookies.txt -d $createdevice -X POST $lavaurl/admin/lava_scheduler_app/device/add/
lava-server manage device-dictionary --hostname s5p4418-navi-ref --import /home/lava/lava-server/lava_scheduler_app/tests/devices/s5p4418-navi-ref.jinja2


#s5p4418-avn-ref
devicename=s5p4418-avn-ref
devicetype=s5p4418-avn-type
# Add device type
csrf="csrfmiddlewaretoken="$(cat  ${tools_path}/cookies.txt | grep csrftoken | cut -d$'\t' -f 7)
createdevicetype=$csrf\&name=$devicetype\&display=on\&health_frequency=24\&_save=Save\&health_denominator=0
curl -b ${tools_path}/cookies.txt -c ${tools_path}/cookies.txt -d $createdevicetype -X POST $lavaurl/admin/lava_scheduler_app/devicetype/add/
## Add device
csrf="csrfmiddlewaretoken="$(cat  ${tools_path}/cookies.txt | grep csrftoken | cut -d$'\t' -f 7)
createdevice=$csrf\&hostname=$devicename\&device_type=$devicetype\&device_version=1\&status=1\&health_status=0\&is_pipeline="on"\&worker_host=lava-slave
curl -b ${tools_path}/cookies.txt -c ${tools_path}/cookies.txt -d $createdevice -X POST $lavaurl/admin/lava_scheduler_app/device/add/
lava-server manage device-dictionary --hostname s5p4418-avn-ref --import /home/lava/lava-server/lava_scheduler_app/tests/devices/s5p4418-avn-ref.jinja2


#s5p6818-avn-ref
devicename=s5p6818-avn-ref
devicetype=s5p6818-avn-type
# Add device type
csrf="csrfmiddlewaretoken="$(cat  ${tools_path}/cookies.txt | grep csrftoken | cut -d$'\t' -f 7)
createdevicetype=$csrf\&name=$devicetype\&display=on\&health_frequency=24\&_save=Save\&health_denominator=0
curl -b ${tools_path}/cookies.txt -c ${tools_path}/cookies.txt -d $createdevicetype -X POST $lavaurl/admin/lava_scheduler_app/devicetype/add/
## Add device
csrf="csrfmiddlewaretoken="$(cat  ${tools_path}/cookies.txt | grep csrftoken | cut -d$'\t' -f 7)
createdevice=$csrf\&hostname=$devicename\&device_type=$devicetype\&device_version=1\&status=1\&health_status=0\&is_pipeline="on"\&worker_host=lava-slave
curl -b ${tools_path}/cookies.txt -c ${tools_path}/cookies.txt -d $createdevice -X POST $lavaurl/admin/lava_scheduler_app/device/add/
lava-server manage device-dictionary --hostname s5p6818-avn-ref --import /home/lava/lava-server/lava_scheduler_app/tests/devices/s5p6818-avn-ref.jinja2
