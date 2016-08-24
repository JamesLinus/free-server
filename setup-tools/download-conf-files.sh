#!/usr/bin/env bash
#
source /opt/.global-utils.sh

downloadFileToFolder ${baseUrlConfigSample}/squid.conf ${configDir}
downloadFileToFolder ${baseUrlConfigSample}/ocserv.conf ${configDir}
downloadFileToFolder ${baseUrlConfigSample}/haproxy.conf ${configDir}
downloadFileToFolder ${baseUrlConfigSample}/haproxy-user.conf ${configDir}

#
## install util
#
## setup tools
#downloadFileToFolder ${baseUrlSetupTools}/init.sh ${freeServerRootTmp}
#downloadFileToFolder ${baseUrlSetupTools}/migrate.sh ${freeServerRootTmp}
#
#downloadFileToFolder ${baseUrlSetupTools}/install-node.sh ${freeServerRootTmp}
#
#downloadFileToFolder ${baseUrlBin}/cron-reboot-daily-generate-cron.d.sh ${binDir}
#
#downloadFileToFolder ${baseUrlSetupTools}/install-letsencrypt.sh ${freeServerRootTmp}
#downloadFileToFolder ${baseUrlBin}/renew-letsencrypt.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/cron-renew-letsencrypt.sh ${binDir}
#
## runtime bin
#downloadFileToFolder ${baseUrlBin}/createuser.sh ${binDir}
#

#downloadFileToFolder ${baseUrlSetupTools}/install-spdy-nghttpx-squid.sh ${freeServerRootTmp}
#downloadFileToFolder ${baseUrlBin}/createuser-spdy-nghttpx-squid.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/restart-spdy-nghttpx-squid.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/start-spdy-nghttpx.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/restart-spdy-squid.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/restart-dead-spdy-nghttpx-squid.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/cron-spdy-nghttpx-squid-forever-process-running-generate-cron.d.sh ${binDir}
#
#downloadFileToFolder ${baseUrlBin}/restart-dead-loadbalancer.sh ${binDir}
#
#downloadFileToFolder ${baseUrlSetupTools}/install-ocserv.sh ${freeServerRootTmp}
#downloadFileToFolder ${baseUrlBin}/createuser-ocserv.sh ${binDir}
##downloadFileToFolder ${baseUrlBin}/deleteuser-ocserv.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/restart-ocserv.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/restart-dead-ocserv.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/cron-ocserv-forever-process-running-generate-cron.d.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/cron-ocserv-renew-route-generate-cron.d.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/renew-route-ocserv.sh ${binDir}
#
##downloadFileToFolder ${baseUrlSetupTools}/install-ipsec-ikev2.sh ${freeServerRootTmp}
##downloadFileToFolder ${baseUrlBin}/createuser-ipsec.sh ${binDir}
##downloadFileToFolder ${baseUrlBin}/deleteuser-ipsec.sh ${binDir}
##downloadFileToFolder ${baseUrlBin}/restart-ipsec.sh ${binDir}
##downloadFileToFolder ${baseUrlBin}/restart-dead-ipsec.sh ${binDir}
##downloadFileToFolder ${baseUrlBin}/cron-ipsec-forever-process-running-generate-cron.d.sh ${binDir}
#
#downloadFileToFolder ${baseUrlBin}/forever-process-running.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/forever-process-running-generate-cron.d ${binDir}
#
#downloadFileToFolder ${baseUrlBin}/cluster-rsync.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/cluster-restart.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/cluster-deploy-ssh-mutual-auth.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/cluster-deploy-ssh-mutual-auth-accept.sh ${binDir}
#
#downloadFileToFolder ${baseUrlMisc}/testing-web.js ${freeServerRootMisc}
#downloadFileToFolder ${baseUrlBin}/restart-misc.sh ${binDir}
#downloadFileToFolder ${baseUrlBin}/cron-misc-forever-process-running-generate-cron.d.sh ${binDir}
#
#
## set executable for all shell scripts
#cd ${binDir}
#chmod -R +x *.sh
#cd ${freeServerRootTmp}
#chmod -R +x *.sh
#
