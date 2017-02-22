# hpgcc3-docker
This is a docker configuration script for the hpgcc3 project which ships C
cross compilation libraries and configurations for the HP 50g calculator. This
project was created because hpgcc3 fails to compile on gcc v6 and above. Hpgcc3 
also depends on the very heavy IDE eclipse. This configuration aims to solve 
these shortcomings by providing a container to provide a controlled environment
for builds to excecute and replacing the heavy eclipse IDE dependency with an
auto configuring makefile. A mechanism is been provided for allowing any
command to be excecuted in the build environment to allow custom configurations.

## Prerequisites:
- docker, preferably with your user in the `docker` group
- root acess to the machine if your user is not in the `docker` group

## Installation
To install type the following commands into the shell:
 
````
git clone https://github.com/Mixih/hpgcc3-docker
cd hpgcc3-docker
docker build -t hpgcc .
````
Then you will need to create the `hpgcc` script somewhere in your PATH by
running:

````
docker run -it hpgcc > hpgcc.sh
chmod +x hpgcc.sh
````
This concludes the install.

## Usage:
Run any compiler comand like it would be done normally with the hpgcc script prefixed like:

````
hpgcc.sh [some command]
````
Use the option `--make` to automatically make the current directory for the hp50g target.


