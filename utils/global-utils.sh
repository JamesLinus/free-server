#!/bin/bash

export globalUtilFile=$0

export bashrc=~/.bashrc

export baseUrl=https://raw.githubusercontent.com/lanshunfang/free-server/master/

# the top install folder
export freeServerRoot=~/free-server/
mkdir -p ${freeServerRoot}

# utility folder
export utilDir=${freeServerRoot}/util
mkdir -p ${utilDir}

# for configration samples
export configDir=${freeServerRoot}/config
mkdir -p ${configDir}

# temporary folder for installation
export freeServerRootTmp=${freeServerRoot}/tmp/

export baseUrlUtils=${baseUrl}/utils
export baseUrlBin=${baseUrl}/bin
export baseUrlSetup=${baseUrl}/setup-tools

export oriConfigShadowsocks="/etc/shadowsocks-libev/config.json"
export configShadowsocks="${configDir}/config.json"


function randomString()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}
export -f randomString

function echoS(){
  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"
  echo "##"
  echo "## $1"
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

#####
# download a file to folder
#
# @param String $1 is the url of file to downlaod
# @param String $2 is the folder to store
# @example downloadFileToFolder http://www.xiaofang.me/some.zip ~/free-server
#####
function downloadFileToFolder(){
  echoS "Prepare to download file $1 into Folder $2"

  if [ ! -d "$2" ]; then
    echoSExit "Folder $2 is not existed. Exit"
  fi
  if [ -z $1 ]; then
    echoSExit "Url must be provided"
  fi
  wget --directory-prefix=$2 "$1" > /dev/null
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
