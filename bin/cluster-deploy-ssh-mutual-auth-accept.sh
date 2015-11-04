#!/bin/bash

source ~/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

echoS "This script is going to deploy SSH public key to all cluster servers"

main() {
  getFilePathFromStdIn
}

getFilePathFromStdIn() {
  publicKey=$(getUserInput "Input new *.pub file absolute path (e.g. /root/.ssh/free-server.me_pub)" file 2)
  echoS "Selected publicKey file is ${publicKey}"
  if [[  ! -f ${key} ]]; then
    echoS ""
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
	cat $1 | ssh $2 "chmod 755 ~/ && mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && cat >>  ~/.ssh/authorized_keys"
}

main "$@"
