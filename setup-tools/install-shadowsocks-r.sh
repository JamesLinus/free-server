#!/usr/bin/env bash

source /opt/.global-utils.sh


cd ${gitRepoPath}

git clone -b manyuser https://github.com/breakwa11/shadowsocks.git

# prepare all Shadowsocks Utils

optimizeLinuxForShadowsocksR

## create first shadowsocks account
#tmpPort=40000
#tmpPwd=`randomString 8`
#${freeServerRoot}/createuser-shadowsocks ${tmpPort} ${tmpPwd}  > /dev/null
#echoS "First Shadowsocks account placeholder created, with Port ${tmpPort} and Password ${tmpPwd}. \n \
#You should not remove the placeholder since it's used by script ${freeServerRoot}/createuser-shadowsocks"
