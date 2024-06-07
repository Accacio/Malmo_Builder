# Malmo Builder
a data collecting environment for project DISCUTER

# Table of Contents
1. [Malmo Installation (SERVER)](#malmo-installation-server)
2. [Using Malmo Builder (SERVER)](#using-malmo-builder-server)
3. [Using Malmo Builder (remote player)](#using-malmo-builder-remote-player)
4. [Adding ability to fly in the mission](#adding-ability-to-fly-in-the-mission)

  
## Malmo Installation (SERVER)

How to install on ubuntu 18.04.6 LTS for other ways to install look at https://github.com/Microsoft/malmo/ 

1. Install the latest version of Malmo from https://github.com/Microsoft/malmo/releases

2. Install dependencies available from the standard repositories:
```sh
sudo apt-get install libboost-all-dev libpython3.5 openjdk-8-jdk ffmpeg python-tk python-imaging-tk

sudo update-ca-certificates

pip install Pillow
```
**notice:** if you have more than one version of java then you must select openjdk version "1.8.0_362" or launching will fail 
```sh
### List all java versions:

update-java-alternatives --list

### Set java version as default (needs root permissions):

sudo update-java-alternatives --set /path/to/java/version

### where /path/to/java/version is one of those listed by the previous command (e.g. /usr/lib/jvm/java-1.8.0-openjdk-amd64).
```

3. export malmo schemas
Add ```export MALMO_XSD_PATH=~/MalmoPlatform/Schemas``` (or your Schemas location) to your ```~/.bashrc``` and then ```source ~/.bashrc```

4. launch
```sh
cd Minecraft
./launchClient.sh 
```
**notice:** if you have a problem with opengl then you may try:
 - restarting your device
 - clean gradle

5. Launch an agent:
Running a Python agent:
```sh
cd Python_Examples
python3 run_mission.py
```
## Using Malmo Builder (SERVER)

1. clone the project in the MalmoPlatform repository

2. navigate to Malmo_Builder

3. run malmo_builder in the terminal 
### define the number of distant clients:
In config.json file change the number of distant clients in the agents section and change the IP address of the server if needed
```sh  
0 : for two local players  
1 : for one local player and one remote player (same LAN network)  
2 : for two remote players (same LAN network)
```sh
"agents": {
    "num_distant_agents": 1
}
```
### experimental version (takes time to load):
```sh 
./malmo_builder_run.sh num_of_clients
```
in which num_of_clients is the number of clients you want to run  
    1 (default) for the server  
    2 for the server and one local player  
    3 for the server and two local players  

### manual version (less time but more work):
#### to run only server:
- run one client
```sh
cd ../Minecraft
./launchClient.sh
```
- run the python script
```sh
python3 main.py
```

#### to run one local player:
- run two clients
```sh
cd ../Minecraft
./launchClient.sh
```
- We need to make the port 10000 our last opened window so we can easily find our log file  
To do so change the last opened client which will be at 10001 to port 10000 and the first one to 10002 using GUI
1. First change the client 10000 to 10001 on minecraft GUI (malmo wont like it but will change it later)  
In the Minecraft window of port 10000:  
ESC > mods > malmo > settings > port  >change 0 to 10001 > done  
2. Then change the client 10002 to 10000 on minecraft GUI  
In the Minecraft window of port 10001:  
ESC > mods > malmo > settings > port > change 0 to 10000 > done  
3. now to solve malmo problem with first change, 10001 to 0  
In the Minecraft window of step 1:  
ESC > mods > malmo > settings > port > 0 > done  

- run the main python file in the malmo_builder directory
```sh
python3 main.py
```
**notice:** if for some reason malmo is not running after launching the client you can try resetting Minecraft folder
## Using Malmo Builder (remote player)
1. install forge 1.11.2 of minecraft launcher
2. copy the malmo jar file (can be found in the ``Mod`` folder of [Malmo Releases](https://github.com/microsoft/malmo/releases)) to the ```.minecraft/mods/``` (create the folder ```mods``` if does not exist)
3. launch Minecraft forge 1.11.2 and you should be seeing the LAN connection of the running server in Multiplayer

## Adding ability to fly in the mission
1. install minecraft mod simply hax (https://www.curseforge.com/minecraft/mc-mods/simply-hax/files?version=1.11.2)
2. add the mod to the ```MalmoPlatform/Minecraft/run/mods ``` folder in the server
3. add the mod to the ```.minecraft/mods/``` (create the folder ```mods``` if does not exist) in the remote player device 
4. When you run the mission you should be able to fly by pressing the ```space``` key twice and then pressing ```space``` and ```shift``` to go up and down  
**notice:** if you have a problem with launching minecraft forge 1.11.2 you should consider restarting your device


