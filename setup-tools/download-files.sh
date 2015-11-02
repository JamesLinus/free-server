#!/usr/bin/env bash

source ~/.global-utils.sh

# install util

downloadFileToFolder ${baseUrlSetup}/init.sh ${freeServerRootTmp}

downloadFileToFolder ${baseUrlSetup}/install-shadowsocks.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlSetup}/install-spdy.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlSetup}/install-ipsec-ikev2.sh ${freeServerRootTmp}

downloadFileToFolder ${baseUrlSetup}/install-node.sh ${freeServerRootTmp}

# runtime util
downloadFileToFolder ${baseUrlBin}/createuser.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/createuser-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/createuser-spdy.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/createuser-ipsec.sh ${utilDir}

downloadFileToFolder ${baseUrlBin}/deleteuser-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/deleteuser-spdy.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/deleteuser-ipsec.sh ${utilDir}

downloadFileToFolder ${baseUrlBin}/restart-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-spdy.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-ipsec.sh ${utilDir}

downloadFileToFolder ${baseUrlBin}/restart-dead-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-dead-spdy.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-dead-ipsec.sh ${utilDir}

downloadFileToFolder ${baseUrlBin}/forever-process-running.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/forever-process-running-generate-cron.d ${utilDir}

downloadFileToFolder ${baseUrlBin}/cron-shadowsocks-forever-process-running-generate-cron.d ${utilDir}
downloadFileToFolder ${baseUrlBin}/cron-spdy-forever-process-running-generate-cron.d ${utilDir}
downloadFileToFolder ${baseUrlBin}/cron-ipsec-forever-process-running-generate-cron.d ${utilDir}
# set executable for all shell scripts
cd ${utilDir}
chmod -R +x *.sh
cd ${freeServerRootTmp}
chmod -R +x *.sh

