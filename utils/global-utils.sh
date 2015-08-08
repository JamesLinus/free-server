#!/bin/bash

export globalUtilFile=$0

export homeDir=`pwd`

export bashrc=${homeDir}/.bashrc

export baseUrl=https://raw.githubusercontent.com/lanshunfang/free-server/master/

# the top install folder
export freeServerRoot=$homeDir/free-server/
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

function echoS(){
  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"
  echo "##"
  echo "## $1"
  echo "##"

  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"

}
export -f echoS


function echoSExit(){
  echoS $1
  exit
}
export -f echoSExit

#####
# insert a line under the matched pattern
#
# @param String $1 is the file to operate
# @param RegExp String $2 is searching pattern for sed
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

  # find and remove the line matched to the pattern
  sed -i "/$2/a" $3 $1
}
export -f insertLineToFile

#####
# replace a line with new line
#
# @param String $1 is the file to operate
# @param RegExp String $2 is searching pattern for sed
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
  sed -i "/$2/a" "__INSERT_POINT__" $1
  sed -i "/$2/d" $1
  sed -i "/__INSERT_POINT__/c" $3 $1
}
export -f replaceLineInFile


#####
# replace a line with new line
#
# @param String $1 is the file to operate
# @param RegExp String $2 is searching pattern for sed
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
  sed -i "/$2/d" $1
}
export -f removeLineInFile



#####
# Add date to String
#
# @param String $1 is the origin String
#####
function appendDateToString(){
  local now=$(date +"%m_%d_%Y")
  echo "$1-$now"
}
export -f appendDateToString
