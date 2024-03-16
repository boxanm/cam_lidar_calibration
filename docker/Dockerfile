FROM ros:noetic

ARG DEBIAN_FRONTEND=noninteractive

# Install basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
         curl \
         gnupg2 \
         lsb-core \
         libpng16-16 \
         libjpeg-turbo8 \
         libtiff5 \
         wget && \
     rm -rf /var/lib/apt/lists/*

# Install ROS 
#RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
#RUN apt install curl # if you haven't already installed curl
#RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
#RUN apt-get update && apt-get install -y --no-install-recommends \
#        ros-noetic-desktop \
#        python-rosdep
#RUN rosdep init
RUN rosdep update
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Intalling ROS basic tools
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
RUN wget http://packages.ros.org/ros.key -O - | apt-key add -

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        python3-catkin-tools \
        python3-pip \
        python3-tk \
        python3-rosinstall \
        python3-rosinstall-generator \
        python3-wstool \
        software-properties-common && \
     rm -rf /var/lib/apt/lists/*

# Catkin workspace setup
RUN mkdir -p /catkin_ws/src

# Initialise workspace
WORKDIR /catkin_ws/src
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_init_workspace"
WORKDIR /catkin_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin build;"
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

# Install cam_lidar_calibration specific dependencies
RUN pip install -U pandas scipy

COPY ./dependencies /tmp/dependencies
RUN apt-get update && \
    sed "s/\noetic/noetic/g" "/tmp/dependencies" | xargs apt-get install -y #&& \
    rm -rf /var/lib/apt/lists/* 
RUN apt-get update && \
  apt-get install -y \
                 ros-noetic-cv-bridge \
                  ros-noetic-image-transport \
                  ros-noetic-rviz \
                  ros-noetic-rqt \
                  ros-noetic-rqt-reconfigure \
                   ros-noetic-eigen-conversions \
                   ros-noetic-tf-conversions

# Clean imaN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* 

CMD ["tail", "-f", "/dev/null"]
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
