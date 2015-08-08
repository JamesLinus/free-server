#!/usr/bin/env bash

source ~/global-utils.sh

# install util
wget ${baseUrlSetup}/install-shadowsocks.sh ${freeServerRootTmp}
wget ${baseUrlSetup}/install-spdy.sh ${freeServerRootTmp}

# runtime util
wget ${baseUrlBin}/createuser.sh ${utilDir}
wget ${baseUrlBin}/createuser-shadowsocks.sh ${utilDir}
wget ${baseUrlBin}/deleteuser-shadowsocks.sh ${utilDir}
wget ${baseUrlBin}/restart-shadowsocks.sh ${utilDir}
wget ${baseUrlBin}/restart-spdy.sh ${utilDir}
wget ${baseUrlBin}/global-utils.sh ${utilDir}

# set executable for all shell scripts
chmod -R +x *.sh
