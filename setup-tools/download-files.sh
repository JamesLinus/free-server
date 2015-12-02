#!/usr/bin/env bash

source /opt/.global-utils.sh

# install util

# setup tools
downloadFileToFolder ${baseUrlSetup}/init.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlSetup}/migrate.sh ${freeServerRootTmp}

downloadFileToFolder ${baseUrlSetup}/install-node.sh ${freeServerRootTmp}
# runtime bin
downloadFileToFolder ${baseUrlBin}/createuser.sh ${utilDir}

downloadFileToFolder ${baseUrlSetup}/install-shadowsocks.sh ${freeServerRootTmp}
#downloadFileToFolder ${baseUrlBin}/deleteuser-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/createuser-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-dead-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/cron-shadowsocks-forever-process-running-generate-cron.d.sh ${utilDir}

#downloadFileToFolder ${baseUrlSetup}/install-spdy.sh ${freeServerRootTmp}
#downloadFileToFolder ${baseUrlBin}/createuser-spdy.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/deleteuser-spdy.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/restart-spdy.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/restart-dead-spdy.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/cron-spdy-forever-process-running-generate-cron.d.sh ${utilDir}

downloadFileToFolder ${baseUrlConfigSample}/squid.conf ${configDir}
downloadFileToFolder ${baseUrlSetup}/install-spdy-nghttpx-squid.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlBin}/createuser-spdy-nghttpx-squid.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-spdy-nghttpx-squid.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/start-spdy-nghttpx.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-spdy-squid.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-dead-spdy-nghttpx-squid.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/cron-spdy-nghttpx-squid-forever-process-running-generate-cron.d.sh ${utilDir}



downloadFileToFolder ${baseUrlSetup}/install-ipsec-ikev2.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlBin}/createuser-ipsec.sh ${utilDir}
#downloadFileToFolder ${baseUrlBin}/deleteuser-ipsec.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-ipsec.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-dead-ipsec.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/cron-ipsec-forever-process-running-generate-cron.d.sh ${utilDir}

downloadFileToFolder ${baseUrlBin}/forever-process-running.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/forever-process-running-generate-cron.d ${utilDir}

downloadFileToFolder ${baseUrlBin}/cluster-rsync.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/cluster-restart.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/cluster-deploy-ssh-mutual-auth.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/cluster-deploy-ssh-mutual-auth-accept.sh ${utilDir}

downloadFileToFolder ${baseUrlMisc}/testing-web.js ${freeServerRootMisc}
downloadFileToFolder ${baseUrlBin}/restart-misc.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/cron-misc-forever-process-running-generate-cron.d.sh ${utilDir}


# set executable for all shell scripts
cd ${utilDir}
chmod -R +x *.sh
cd ${freeServerRootTmp}
chmod -R +x *.sh

