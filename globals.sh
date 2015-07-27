#!/bin/bash

export config_shadowsocks="/etc/shadowsocks-libev/config.json"

bashrc=~/.bashrc
source ${bashrc}

echoS(){
  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"
  echo "##"
  echo "## $1"
  echo "##"

  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"

}

echoSExit(){
  echoS $1
  exit
}

export -f echoS
export -f echoSExit