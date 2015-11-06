#!/usr/bin/env bash

source /root/.global-utils.sh

# clusterDefFilePath in /root/.global-utils.sh

init() {
  createConfigFile
}

createConfigFile() {
  touch ${clusterDefFilePath}
  echo "# Guide: Put a server domain for SSH Mutual Auth per line, with Linux User. E.g: " >> ${clusterDefFilePath}
  echo "# root@vpn1.free-server.me" >> ${clusterDefFilePath}
  echo "# root@vpn2.free-server.me" >> ${clusterDefFilePath}
}

linkToShortCut() {
  ln -s ${utilDir}/cluster-rsync.sh ${freeServerRoot}/cluster-rsync
  ln -s ${utilDir}/cluster-restart.sh ${freeServerRoot}/cluster-restart
  ln -s ${utilDir}/cluster-deploy-ssh-mutual-auth.sh ${freeServerRoot}/cluster-deploy-ssh-mutual-auth
  ln -s ${utilDir}/cluster-deploy-ssh-mutual-auth-accept.sh ${freeServerRoot}/cluster-deploy-ssh-mutual-auth-accept
}

init "$@"
