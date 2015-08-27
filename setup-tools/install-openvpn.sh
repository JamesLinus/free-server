#!/usr/bin/env bash

source ~/.global-utils.sh

sudo apt-get install openvpn bridge-utils -y > /dev/null


key=$(getUserInput "Input *.key File Path (e.g. /root/mydomain.com.key. Could omited if you've done before):   " file 2)
echoS "Selected key file is ${key}"

cert=$(getUserInput "Input *.crt file with the key (e.g. /root/mydomain.com.crt Could omited if you've done before) :  " file 2)
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
