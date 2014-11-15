#!/bin/bash
# this is a VERY basic setup script meant to run on ubuntu

# must be run as root b/c of the fig install

sudo apt-get -y update
sudo apt-get -y install docker.io

# docker tab completion (only lasts for this session)
source /etc/bash_completion.d/docker.io

curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
