#!/bin/bash

source /root/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

echoS "This script is going to deploy SSH public key to all cluster servers"
echoS "You should make sure have line \x1b[46m 'PermitRootLogin yes'\x1b[0m in \x1b[40m/etc/ssh/sshd_config\x1b[0m\
 in remote cluster servers before continue"


publicKey=""

main() {
  getPubKeyFilePathFromStdIn
  readServerListFromFileAndDeploySSHPubKey
}

readServerListFromFileAndDeploySSHPubKey() {

	for lineAsDomain in $(cat "${clusterDefFilePath}"); do

		isCommentLine=$(echo ${lineAsDomain} | gawk --posix '/^($|\s*#)/')

		if [[ ! -z ${isCommentLine} ]]; then
			continue
		fi

		echo "Deploying SSH PubKey to Server ${lineAsDomain}"
		sshPutPubKeyToServer ${publicKey} ${lineAsDomain}
		echoS "You should make sure have line \x1b[46m 'PermitRootLogin yes'\x1b[0m in \x1b[40m/etc/ssh/sshd_config\x1b[0m\
 in remote cluster server ${lineAsDomain} before continue"

	done
}

getPubKeyFilePathFromStdIn() {
  publicKey=$(getUserInput "Input new *.pub file absolute path (e.g. /root/.ssh/free-server.org_pub)" file 3)
  if [[  ! -f ${key} ]]; then
    echoS "${publicKey} is not a file. Exit."
    exit 0
  else
    echoS "Selected publicKey file is ${publicKey}"
  fi
}

sshPutPubKeyToServer() {
	if [[ -z $(echo $1 | awk '/.pub/ {print}') ]];then
		echo "Usage: sshPutPubKeyToServer KEY.pub USER@Domain.\n\n\
		 The key should include '.pub' as its file name.\n\
		 e.g: sshPutPubKeyToServer /root/.ssh/id_pub ec2-user@www.free-server.org\n\n\
		 "
		return 0
	fi
	if [[ -z $(echo $2 | awk '/@/ {print}') ]];then
		echo "Usage: sshPutPubKeyToServer KEY.pub USER@Domain.\n\n\
		 USER@Domain should include '@' sign.\n\
		 e.g: sshPutPubKeyToServer /root/.ssh/id_pub ec2-user@www.free-server.org\n\n\
		 "
		return 0
	fi
	pubKeyStr=$(cat $1)
	ssh $2 "echo \"${pubKeyStr}\" | ${clusterDeploySSHMutualAuthAccept}"
	#TODO

}

main "$@"
