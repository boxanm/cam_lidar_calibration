#!/bin/bash

# Default setting
CUDA="off"


if [ $CUDA == "on" ]; 
then
    ENVS="--env=NVIDIA_VISIBLE_DEVICES=all
	  --env=NVIDIA_DRIVER_CAPABILITIES=all
	  --env=DISPLAY=$DISPLAY
	  --env=QT_X11_NO_MITSHM=1
	  --gpus all"
	echo "Running docker with Cuda support"
else
	ENVS="--env=XAUTHORITY=/home/$(id -un)/.Xauthority
		  --env=ROS_IP=127.0.0.1
		  --env=DISPLAY=$DISPLAY"
	echo "Running docker for cpu"
fi

XSOCK=/tmp/.X11-unix
XAUTH=$HOME/.Xauthority
VOLUMES="--volume=$XSOCK:$XSOCK
		 --volume=$XAUTH:/home/$(id -un)/.Xauthority
		 --volume=${PWD}/..:/catkin_ws/src/cam_lidar_calibration"

xhost +local:docker

docker run \
-it --rm \
$VOLUMES \
$ENVS \
--privileged \
--net=host \
--workdir="/catkin_ws/src" \
darrenjkt/cam_lidar_calibration:latest-noetic /bin/bash
