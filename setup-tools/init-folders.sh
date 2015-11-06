#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
  createFolderByPath ${freeServerRoot}
  createFolderByPath ${utilDir}
  createFolderByPath ${configDir}
  createFolderByPath ${freeServerRootTmp}
}

createFolderByPath() {
  path=$1
  mkdir -p ${path}
  chown proxy.proxy ${path}
  chmod -R 755 ${path}
}

main "$@"



