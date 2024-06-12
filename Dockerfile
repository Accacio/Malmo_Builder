FROM osrf/ros:noetic-desktop-full
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
# RUN apt-get install -y git ros-noetic-moveit ros-noetic-ros-controllers ros-noetic-gazebo-ros-control ros-noetic-rosserial ros-noetic-rosserial-arduino ros-noetic-roboticsgroup-upatras-gazebo-plugins ros-noetic-actionlib-tools python3-pip ros-noetic-librealsense2

RUN apt install -y mesa-utils \
    wget \
    git \
    doxygen \
    build-essential \
    libpython3.8-dev \
    openjdk-8-jdk\
    swig \
    xsltproc\
    ffmpeg \
    git \
    libbz2-dev \
    libgl1-mesa-dri \
    libpython3.8-dev \
    openjdk-8-jdk \
    python3-pil.imagetk \
    python3-pip \
    python3-tk \
    software-properties-common \
    swig \
    unzip \
    wget \
    xpra \
    xsltproc \
    xvfb \
    zlib1g-dev
RUN sudo update-ca-certificates -f

RUN useradd --create-home --shell /bin/bash --no-log-init --groups sudo malmo
RUN sudo bash -c 'echo "malmo ALL=(ALL:ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'
USER malmo

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> /home/malmo/.bashrc

RUN mkdir /home/malmo/boost
WORKDIR /home/malmo/boost
RUN wget http://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.gz
RUN tar xvf boost_1_72_0.tar.gz
WORKDIR /home/malmo/boost/boost_1_72_0
RUN echo "using python : 3.8 : /usr/bin/python3 : /usr/include/python3.8 : /usr/lib ;" > /home/malmo/user-config.jam
RUN ./bootstrap.sh --prefix=.
RUN ./b2 link=static cxxflags=-fPIC install

RUN git clone --branch master https://github.com/Accacio/malmo.git /home/malmo/MalmoPlatform
RUN wget https://raw.githubusercontent.com/bitfehler/xs3p/1b71310dd1e8b9e4087cf6120856c5f701bd336b/xs3p.xsl -P /home/malmo/MalmoPlatform/Schemas
ENV MALMO_XSD_PATH=/home/malmo/MalmoPlatform/Schemas
RUN mkdir /home/malmo/MalmoPlatform/build
WORKDIR /home/malmo/MalmoPlatform/build

RUN cmake -DSTATIC_BOOST=ON -DBoost_INCLUDE_DIR=/home/malmo/boost/boost_1_72_0/include -DUSE_PYTHON_VERSIONS=$python -DBOOST_PYTHON_NAME=python38 -DCMAKE_BUILD_TYPE=Release ..
RUN make -j8 install

WORKDIR /home/malmo/MalmoPlatform/Minecraft
RUN ./gradlew build -x getAssets
