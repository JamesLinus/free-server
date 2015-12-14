#!/usr/bin/env bash

apt-get install nodejs -y > /dev/null
apt-get install npm -y > /dev/null

# fix Ubuntu spdyproxy bug
apt-get install nodejs-legacy > /dev/null
