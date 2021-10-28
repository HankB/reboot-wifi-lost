#!/bin/bash

# see https://github.com/HankB/reboot-wifi-lost/blob/main/README.md for
# installation and usage notes

set -e # exit on error
set -u # exit on unset variable

if [ "$*""" = "" ] ; then
    echo "Usage $0 IP"
    exit 1
fi

count=0
ping_delay=60
ping_repeat=5

# ping the target the desired number of times. If 'ping' is successful,
# the 'let count="0"' executres, returns a non zero exit code and the 
# script exits due to 'set -e'. If all 'ping' operations fail, the host
# reboots.
while [ $count -lt "$ping_repeat" ] ; do
    sleep "$ping_delay"
    # shellcheck disable=SC2015 # SC2015 is intended logic
    ping -c1 "$1" &> /dev/null && let count="0"|| let count="$count + 1" 
done

reboot

