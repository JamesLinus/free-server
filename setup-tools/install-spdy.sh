#!/usr/bin/env bash

source ~/global-utils.sh

echoS "Please input the file (with path) of your SSL Key file  (*.key) : \n\n(You could not use self-signed SSL cert. You could get \
a free copy from https://www.startssl.com/)\n"

maxTryKey=3
while [ ${maxTryKey} -gt 0 ]; do
  read -p "Input *.key File Path (e.g. /root/mydomain.com.key):  " key
  key=$(removeWhiteSpace "${key}")

  if [[ ! -f ${key} ]]; then
    echoS "The SSL Key file ${key} is not existed. Retry."
  else
    break
  fi
  ((maxTryKey--))

done




echoS "Please input the file (with path) of your SSL Cert file  (*.crt) : \n\n"


maxTryCert=3
while [ ${maxTryCert} -gt 0 ]; do
  read -p "Input *.crt File Path (e.g. /root/mydomain.com.crt): " cert

  cert=$(removeWhiteSpace "${cert}")

  if [[ ! -f ${cert} ]]; then
    echoS "The SSL cert file ${cert} is not existed. Retry"
  else
    break
  fi
  ((maxTryCert--))
done

if [[  -f ${key} ||  -f ${cert} ]]; then
  echoS "Copy Key ${key} and Cert ${cert} to ${configDir}"
  cp ${key} ${SPDYSSLKeyFile}
  cp ${cert} ${SPDYSSLCertFile}
fi


sudo npm install -g spdyproxy

ln -s ${utilDir}/createuser-spdy.sh ${freeServerRoot}/createuser-spdy
ln -s ${utilDir}/deleteuser-spdy.sh ${freeServerRoot}/deleteuser-spdy
ln -s ${utilDir}/restart-spdy.sh ${freeServerRoot}/restart-spdy
ln -s ${utilDir}/restart-dead-spdy.sh ${freeServerRoot}/restart-dead-spdy
