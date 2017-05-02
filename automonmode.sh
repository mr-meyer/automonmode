#!/usr/bin/env bash

# interfaces.sh
# script for listing interfaces to switch between monitor and station mode

interfaces=(`ip link show | awk 'NR % 2 {print $2}' | grep '^w' |  sed 's/://'`)

printf "\n"
printf "Select network interface to put into monitor mode:\n\n"
item_number=0
for each_line in ${interfaces[@]}
do
    printf "$item_number: ${interfaces[item_number]}\n"
    item_number=$((item_number + 1))
done
printf "\n"
