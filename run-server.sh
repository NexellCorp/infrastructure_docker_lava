#!/bin/bash

docker run -itd --name new_lava_server --cap-add=NET_ADMIN -p 9099:80 -p 5557:5555 -p 5558:5556 -h new_lava_server nexelldocker/lava-server:2018.11
