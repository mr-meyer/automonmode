#!/usr/bin/env bash

# interfaces.sh
# script for listing interfaces to switch between monitor and station mode

sudo echo ''

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

read interface_choice

old_iface=${interfaces[interface_choice]}
new_iface="wlan$interface_choice"

sudo ip link set $old_iface down
sudo ip link set $old_iface name $new_iface
sudo macchanger -r $new_iface
sudo ip link set $new_iface up
sudo airmon-ng start $new_iface

