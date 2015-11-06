#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
  oldFolder=$(getObseleteInstallationFolder)
  if [[ -d ${oldFolder} ]]; then
    migrateOldToNew ${oldFolder}
  fi
}

getObseleteInstallationFolder() {
  echo "~/free-server"
}

migrateOldToNew() {
  oldFolder=$1
  newFolder=${freeServerRoot}
  migrateBak=${oldFolder}.migrated.bak
  if [[ -d ${newFolder} ]]; then
    echoS "[Error] Both old installation folder ${oldFolder} and new installation folder ${newFolder} exists. \n\
    Please merge the ${oldFolder}/config/ and ${newFolder}/config/ manually before continue" "stderr"
    return 1
    exit 1
  fi
  rm -rf ${migrateBak}
  cp -r ${oldFolder} ${migrateBak}
  mkdir -p ${newFolder}
  mv ${oldFolder}/config ${newFolder}/config

}

main "$@"



