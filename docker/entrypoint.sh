#!/bin/bash

source /opt/ros/noetic/setup.bash
catkin build
source /catkin_ws/devel/setup.bash
exec "$@"
