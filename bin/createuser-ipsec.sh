#!/bin/bash

source ~/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 USERNAME PASSWORD"
  exit 0
fi


if [[ ! -f ${ipsecSecFile} ]]; then
  echoS "IPSec config file (${ipsecSecFile}) is not detected. This you may not install it correctly. Exit."
  exit 1
fi


username=$1
password=$2

( [[ -z "${username}" ]]  || [[ -z "${password}" ]] ) \
 && echoS "You should invoke me via \`$0 USERNAME PASSWORD \`. \
 None of the parameters could be omitted." \
 && exit 0

if [[ ! -z $(gawk "/^${username} / {print}" ${ipsecSecFile}) ]]; then
  echoS "Ooops, the user ${username} is exited in file ${ipsecSecFile} already. Exit"
  exit 0
fi


#newline=${username},${password},${port}
newline=${username} %any : EAP \"${password}\"

echo ${newline} >> ${ipsecSecFile}

ipsec restart

echoS "IPSec account created with \n\n\
Username: $username \n\
Password: $password \n\n\
if file ${ipsecSecFile} \n\
"
