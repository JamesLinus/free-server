#!/usr/bin/env bash

source ~/global-utils.sh

# install util
wget --directory-prefix=${freeServerRootTmp} ${baseUrlSetup}/install-shadowsocks.sh
wget --directory-prefix=${freeServerRootTmp} ${baseUrlSetup}/install-spdy.sh

# runtime util
wget --directory-prefix=${utilDir} ${baseUrlBin}/createuser.sh
wget --directory-prefix=${utilDir} ${baseUrlBin}/createuser-shadowsocks.sh
wget --directory-prefix=${utilDir} ${baseUrlBin}/deleteuser-shadowsocks.sh
wget --directory-prefix=${utilDir} ${baseUrlBin}/restart-shadowsocks.sh
wget --directory-prefix=${utilDir} ${baseUrlBin}/restart-spdy.sh
wget --directory-prefix=${utilDir} ${baseUrlBin}/global-utils.sh

# set executable for all shell scripts
cd ${freeServerRoot}
chmod -R +x *.sh
