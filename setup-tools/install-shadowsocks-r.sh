#!/usr/bin/env bash

source /opt/.global-utils.sh


#downloadFileToFolder ${baseUrlSetup}/install-shadowsocks.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlSetup}/install-shadowsocks-r.sh ${freeServerRootTmp}
#downloadFileToFolder ${baseUrlBin}/deleteuser-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/deleteuser-shadowsocks-r.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/createuser-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/createuser-shadowsocks-r.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/restart-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-shadowsocks-r.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/restart-dead-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-dead-shadowsocks-r.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/cron-shadowsocks-forever-process-running-generate-cron.d.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/cron-shadowsocks-r-forever-process-running-generate-cron.d.sh ${utilDir}

downloadFileToFolder ${baseUrlBin}/updateuser-shadowsocks-r-qrcode.sh ${utilDir}


cd ${freeServerRootTmp}
git clone -b manyuser https://github.com/breakwa11/shadowsocks.git

# prepare all Shadowsocks Utils
ln -s ${utilDir}/createuser-shadowsocks-r.sh ${freeServerRoot}/createuser-shadowsocks-r
ln -s ${utilDir}/deleteuser-shadowsocks-r.sh ${freeServerRoot}/deleteuser-shadowsocks-r
ln -s ${utilDir}/restart-shadowsocks-r.sh ${freeServerRoot}/restart-shadowsocks-r
ln -s ${utilDir}/restart-dead-shadowsocks-r.sh ${freeServerRoot}/restart-dead-shadowsocks-r
ln -s ${utilDir}/updateuser-shadowsocks-r-qrcode.sh ${freeServerRoot}/updateuser-shadowsocks-r-qrcode

optimizeLinuxForShadowsocksR

## create first shadowsocks account
#tmpPort=40000
#tmpPwd=`randomString 8`
#${freeServerRoot}/createuser-shadowsocks ${tmpPort} ${tmpPwd}  > /dev/null
#echoS "First Shadowsocks account placeholder created, with Port ${tmpPort} and Password ${tmpPwd}. \n \
#You should not remove the placeholder since it's used by script ${freeServerRoot}/createuser-shadowsocks"
