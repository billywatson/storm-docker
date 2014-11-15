#!/bin/bash
# this is a VERY basic setup script meant to run on ubuntu
# this script must be run as root b/c of the fig install

curl -sSL https://get.docker.com/ubuntu/ | sudo sh

curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
