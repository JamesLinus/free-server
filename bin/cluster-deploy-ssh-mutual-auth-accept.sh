#!/bin/bash

source ~/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

echoS "This script accept remote SSH mutual auth PubKey deploy"

main() {
	prepareEnv
	cat >>  ~/.ssh/authorized_keys
	acceptPubKeyStrToAuthKeyFile $1
}

prepareEnv() {
	chmod 755 ~/
	mkdir -p ~/.ssh
	touch ~/.ssh/authorized_keys
	chmod 600 ~/.ssh/authorized_keys
}

acceptPubKeyStrToAuthKeyFile() {


}

main "$@"
