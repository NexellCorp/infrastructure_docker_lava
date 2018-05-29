#!/bin/bash

docker run -it --name con_lava_server -p 80:80 -p 5555:5555 -p 5556:5556 -h lava-server nexelldocker/lava-server
