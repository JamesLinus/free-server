#!/bin/bash

export globalUtilFile=$0

export bashrc=~/.bashrc

export baseUrl=https://raw.githubusercontent.com/lanshunfang/free-server/master/

# the top install folder
export freeServerRoot=~/free-server/

# utility folder
export utilDir=${freeServerRoot}/util

# for configration samples
export configDir=${freeServerRoot}/config

# temporary folder for installation
export freeServerRootTmp=${freeServerRoot}/tmp

export baseUrlUtils=${baseUrl}/utils
export baseUrlBin=${baseUrl}/bin
export baseUrlSetup=${baseUrl}/setup-tools

export oriConfigShadowsocksDir="/etc/shadowsocks-libev/"
export oriConfigShadowsocks="${oriConfigShadowsocksDir}/config.json"

export SPDYConfig="${configDir}/SPDY.conf"
export SPDYSSLKeyFile="${configDir}/SPDY.domain.key"
export SPDYSSLCertFile="${configDir}/SPDY.domain.crt"


function randomString()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}
export -f randomString

function echoS(){
  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"
  echo "##"
  echo -e "## $1"
  echo "##"

  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"

}
export -f echoS


function echoSExit(){
  echoS "$1"
  sleep 1
  exit 0
}
export -f echoSExit

function killProcessesByPattern(){
  echo -e "\nThe process(es) below would be killed"
  ps aux | gawk '/'$1'/ {print}' | cut -d" " -f 24-
  ps aux | gawk '/'$1'/ {print $2}' | xargs kill -9
  echo -e "\n\n"

}
export -f killProcessesByPattern

function removeWhiteSpace(){
  echo $(echo "$1" | gawk '{gsub(/ /, "", $0); print}')
}
export -f removeWhiteSpace

#####
# get interfact IP
#####
function getIp(){
  /sbin/ifconfig|grep 'inet addr'|cut -d':' -f2|awk '!/127/ {print $1}'
}
export -f getIp

#####
# download a file to folder
#
# @param String $1 is the url of file to downlaod
# @param String $2 is the folder to store
# @example downloadFileToFolder http://www.xiaofang.me/some.zip ~/free-server
#####
function downloadFileToFolder(){
  echo "Prepare to download file $1 into Folder $2"

  if [ ! -d "$2" ]; then
    echoS "Folder $2 is not existed. Exit"
    exit 0
  fi
  if [ -z $1 ]; then
    echoS "Url must be provided. Exit"
    exit 0
  fi
  wget -q --directory-prefix="$2" "$1"
}
export -f downloadFileToFolder



#####
# insert a line under the matched pattern
#
# @param String $1 is the file to operate
# @param RegExp String $2 is searching pattern for awk
# @param String $3 is line to insert to the found pattern
#####
function insertLineToFile(){

  if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
  then
    echo "$FUNCNAME FileName SearchingPattern LineToAdd"
    exit 0
  fi

  # all the arguments should be given
  if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]];then
    echo "You should provide all 3 arguments to invoke $$FUNCNAME"
    exit 1
  fi

  if [[ ! -f $1 ]]; then
    echo "File $1 is not existed"
    exit 1
  fi

  gawk -i inplace "/$2/ {print;print $3;next}1" $1

}
export -f insertLineToFile

#####
# replace a line with new line
#
# @param String $1 is the file to operate
# @param RegExp String $2 is searching pattern for awk
# @param String $3 is line to insert to the found pattern after the matched line removed
#####
function replaceLineInFile(){

  if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
  then
    echo "$FUNCNAME FileName SearchingPattern NewLine"
    exit 0
  fi

  # all the arguments should be given
  if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]];then
    echo "You should provide all 3 arguments to invoke $FUNCNAME"
    exit 1
  fi

  if [[ ! -f $1 ]]; then
    echo "File $1 is not existed"
    exit 1
  fi

  # find and remove the line matched to the pattern
  gawk -i inplace "{gsub(/$2/, $3)}; {print}" $1
}
export -f replaceLineInFile


#####
# replace a line with new line
#
# @param String $1 is the file to operate
# @param RegExp String $2 is searching pattern for awk
#####
function removeLineInFile(){

  if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
  then
    echo "$FUNCNAME FileName SearchingPattern"
    exit 0
  fi

  # all the arguments should be given
  if [[ -z $1 ]] || [[ -z $2 ]];then
    echo "You should provide all 2 arguments to invoke $$FUNCNAME"
    exit 1
  fi

  if [[ ! -f $1 ]]; then
    echo "File $1 is not existed"
    exit 1
  fi

  # find and remove the line matched to the pattern
  gawk -i inplace "!/$2/" $1
}
export -f removeLineInFile


#####
# Add date to String
#
# @param String $1 is the origin String
# @example file$(appendDateToString).bak
#####
function appendDateToString(){
  local now=$(date +"%m_%d_%Y")
  echo "-${now}"
}
export -f appendDateToString



#####
# Import MySQL db sql backup tar.gz to database
#
# @param String $1 is the backup folder to list
# @param String $2 is the database name
# @example importSqlTarToMySQL Folder DbName NewDbUserName(Non-root)
#####
function importSqlTarToMySQL(){

  dbFolder=$1
  dbName=$2
  dbNewUser=$3

  if [[ -z ${dbFolder} || -z ${dbName} || -z ${dbNewUser} ]]; then
    echoS "@example importSqlTarToMySQL ~/backup/ wp wp"
    return 0
  fi

#  # provide the new user name
#  maxTry=3
#  while [ ${maxTry} -gt 0 ]; do
#    read -p "You new MySQL Database user name (Non-root):  " mysqlUsername
#    mysqlUsername=$(removeWhiteSpace "${dbTarGz}")
#
#    if [[ -z ${mysqlUsername} ]]; then
#      echoS "You need to provide the user before move on . Retry."
#    else
#      break
#    fi
#    ((maxTry--))
#  done
#
#  if [[  -z ${mysqlUsername} ]]; then
#    exit 0
#  fi


  # provide the password for the new user name
  maxTry=3
  while [ ${maxTry} -gt 0 ]; do
    read -p "Input password to create the new MySQL user (Non-root):  " mysqlUserPass
    mysqlUserPass=$(removeWhiteSpace "${mysqlUserPass}")

    if [[ -z ${mysqlUserPass} ]]; then
      echoS "You need to provide the password before move on . Retry."
    else
      break
    fi
    ((maxTry--))
  done

  if [[  -z ${mysqlUserPass} ]]; then
    exit 0
  fi

  # select tar.gz
  ls ${dbFolder}
  maxTry=3
  while [ ${maxTry} -gt 0 ]; do
    read -p "Select the tar.gz in folder ${dbFolder} to import:  " dbTarGz
    dbTarGz=$(removeWhiteSpace "${dbTarGz}")

    if [[ ! -f ${dbTarGz} ]]; then
      echoS "The Db Sql Tar file ${dbTarGz} is not existed. Retry."
    else
      break
    fi
    ((maxTry--))
  done

  if [[  -f ${dbTarGz} ]]; then
    rm -rf ~/_to_import
    mkdir ~/_to_import
    tar zxf ${dbTarGz} -C ~/_to_import
    cd ~/_to_import

    # create user and grant
    echoS "Create new Db User ${dbNewUser} and grant. Provide MySQL root password:"
    sql="CREATE DATABASE ${dbName}; GRANT ALL PRIVILEGES ON ${dbName}.* To '${dbNewUser}'@'localhost' IDENTIFIED BY '${mysqlUserPass}';FLUSH PRIVILEGES;"
    mysql -uroot -p -e "$sql"

    echoS "Exact and import ${dbTarGz} to Db ${dbName}.  Provide MySQL root password:"
    mysql -uroot -p -h localhost ${dbName} < $(ls . | gawk '/\.sql/ {print}')
  else
    echoS "${dbTarGz} not found. Exit."
  fi
}
export -f importSqlTarToMySQL
