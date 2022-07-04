#!/bin/bash
#Carlos Grillet

var1=$(ip addr | egrep -o "[0-9]{2,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")

for interface in $var1
do
  if [[ $interface != "127.0.0.1" ]]
  then
    var2=$(ping -I $interface -c 1 8.8.8.8 | egrep -o "\s[0-9]{2,3}\.[0-9]{3}")
    if [[ $var2 == "" ]]
    then
      var3="NULL"
    else
      var3=$(echo $var2 | cut -d " " -f 2)
    fi
    echo $interface rtt $var3 ms
  fi
done
