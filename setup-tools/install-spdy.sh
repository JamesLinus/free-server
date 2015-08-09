#!/usr/bin/env bash

source ~/global-utils.sh

echoS "Please input the file (with path) of your SSL Key file  (*.key) : \n\n(You could not use self-signed SSL cert. You could get \
a free copy from https://www.startssl.com/)\n"

read key

if [[ ! -f ${key} ]]; then
  echoS "The SSL Key file ${key} is not existed. Exit"
  exit 0
fi


echoS "Please input the file (with path) of your SSL Cert file  (*.crt) : \n\n(You could not use self-signed SSL cert. You could get \
a free copy from https://www.startssl.com/)\n"

read cert


if [[ ! -f ${cert} ]]; then
  echoS "The SSL cert file ${cert} is not existed. Exit"
  exit 0
fi

removeLineInFile ~/global-utils.sh "SPDYSSLKeyFile="
insertLineToFile ~/global-utils.sh "SPDYSSLKeyFile=${key}"

removeLineInFile ~/global-utils.sh "SPDYSSLCertFile="
insertLineToFile ~/global-utils.sh "SPDYSSLCertFile=${cert}"

source ~/global-utils.sh

sudo npm install -g spdy

ln -s ${utilDir}/createuser-spdy.sh ${freeServerRoot}/createuser-spdy
ln -s ${utilDir}/deleteuser-spdy.sh ${freeServerRoot}/deleteuser-spdy
ln -s ${utilDir}/restart-spdy.sh ${freeServerRoot}/restart-spdy
ln -s ${utilDir}/restart-dead-spdy.sh ${freeServerRoot}/restart-dead-spdy
