#!/bin/bash

source ~/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 USERNAME PASSWORD PORT"
  exit 0
fi

if [[ ! -f ${SPDYConfig} ]]; then
  touch ${SPDYConfig}
fi

if [[ ! -f ${SPDYSquidPassWdFile} ]]; then
  touch ${SPDYSquidPassWdFile}
fi


if [[ ! -f ${SPDYSSLKeyFile} ]]; then
  echoS "The SSL Key file ${key} is not existed. Exit"
  sleep 2
  exit 0
fi


if [[ ! -f ${SPDYSSLCertFile} ]]; then
  echoS "The SSL cert file ${cert} is not existed. Exit"
  sleep 2
  exit 0
fi

username=$1
password=$2
port=$3

( [[ -z "${username}" ]]  || [[ -z "${password}" ]] || [[ -z "${port}" ]] ) \
 && echoS "You should invoke me via \`$0 USERNAME PASSWORD PORT \`. \
 None of the parameters could be omitted." \
 &&  sleep 2 && exit 0

if [[ ! -z $(gawk "/^${username},/ {print}" ${SPDYConfig}) ]]; then
  echoS "Ooops, the user ${username} is exited in file ${SPDYConfig} already. Exit"
  sleep 2
  exit 0
fi


if [[ ! -z $(gawk "/,${port}$/ {print}" ${SPDYConfig}) ]]; then
  echoS "Ooops, the port ${port} is taken in file ${SPDYConfig} already. Exit"
  sleep 2
  exit 0
fi

newline=${username},${password},${port}

echo ${newline} >> ${SPDYConfig}

#spdyproxy -k ${SPDYSSLKeyFile} -c ${SPDYSSLCertFile} -p $port -U $username -P $password >/dev/null 2>&1  &
${freeServerRoot}/start-spdy-nghttpx ${port}

echo ${password} | htpasswd -i ${SPDYSquidPassWdFile} ${username}

${freeServerRoot}/restart-spdy-squid

echoS "SPDY account created with \n\
Username: $username \n\
Password: $password \n\
Port: $port \n\
"
