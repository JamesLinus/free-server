#!/usr/bin/env bash

source ~/.global-utils.sh

echoS "Please input the file (with path) of your SSL Key file  (*.key) : \n\n(You could not use self-signed SSL cert. You could get \
a free copy from https://www.startssl.com/)\n"


key=$(getUserInput "Input *.key File Path (e.g. /root/mydomain.com.key):   " file 1)
echoS "Selected key file is ${key}"

cert=$(getUserInput "input the file (with path) of your SSL Cert file  (*.crt) :  " file 1)
echoS "Selected cert file is ${cert}"

if [[  -f ${key} &&  -f ${cert} ]]; then
  echoS "Copy Key ${key} and Cert ${cert} to ${configDir}"
  cp ${key} ${SPDYSSLKeyFile}
  cp ${cert} ${SPDYSSLCertFile}
fi

sudo npm install -g spdyproxy > /dev/null 2>&1

ln -s ${utilDir}/createuser-spdy.sh ${freeServerRoot}/createuser-spdy
ln -s ${utilDir}/deleteuser-spdy.sh ${freeServerRoot}/deleteuser-spdy
ln -s ${utilDir}/restart-spdy.sh ${freeServerRoot}/restart-spdy
ln -s ${utilDir}/restart-dead-spdy.sh ${freeServerRoot}/restart-dead-spdy
