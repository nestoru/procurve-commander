#!/bin/bash -e
# procurve-commander.sh
#
# @author: Nestor Urquiza
# @date: 20180316
# @description: Sends the comma separated commands to an HP Procurve switch
# @env: SWITCH_PASSWORD
#

USAGE="Usage: `basename $0` <user> <host> <commands (separated by comma)>"

if [ $# -lt "3" ] 
then
    echo $USAGE
    exit 1 
fi

if [ -z "$SWITCH_PASSWORD" ]
then
    echo SWITCH_PASSWORD environment variable not set
    exit 1
fi

user=$1
host=$2
commands=$3

# set bash internal field separator to comma
IFS=,

# iterate througg commands to build expect commands
for command in $commands; do
  # trim
  command=`echo $command |  xargs`
  toBeSent="${toBeSent}expect \"#\"; send \"$command\n\"; "
done

# write the expect script into the $es variable
es="expect -c '"
es="${es}  set timeout 20;"
es="${es}  spawn ssh $user@$host;"
es="${es}  expect \"password\";"
es="${es}  send \"$SWITCH_PASSWORD\n\";"
es="${es}  expect \"continue\";"
es="${es}  send \"\n\";"
es="${es}  $toBeSent"
es="${es}  expect \"#\";"
es="${es}  send \"exit\n\";"
es="${es}  expect \">\";"
es="${es}  send \"exit\n\";"
es="${es}  expect \"log out\";"
es="${es}  send \"y\""
es="${es}  '"

# reset IFS to default value (usually space)
unset IFS

# execute the expect script
eval $es

# clean new line for prompt
echo
