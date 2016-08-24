#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
  createFolderByPath ${freeServerRoot}
  createFolderByPath ${binDir}
  createFolderByPath ${configDir}
  createFolderByPath ${freeServerRootTmp}
  createFolderByPath ${freeServerRootMisc}
  createFolderByPath ${loggerStdoutFolder}
  createFolderByPath ${letsencryptInstallationFolder}
  createFolderByPath ${gitRepoPath}


  touch ${loggerStdoutFile}
  touch ${ocservPasswd}

  touch ${loggerStderrFile}
  touch ${loggerRuntimeInfoFile}
  touch ${loggerRuntimeErrFile}
  touch ${freeServerGlobalEnv}
}

createFolderByPath() {
  path=$1
  mkdir -p ${path}
  chown proxy.proxy ${path}
  chmod -R 755 ${path}
}

main "$@"



