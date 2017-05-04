#!/usr/bin/env bash

# interfaces.sh
# script for listing interfaces to switch between monitor and station mode

sudo echo ''


while true
do

    item_number=0
    interfaces=(`ip link show | awk 'NR % 2 {print $2}' | grep '^w' |  sed 's/://'`)

    printf "\n"
    printf "Select network interface to switch modes:\n\n"
    for each_line in ${interfaces[@]}
    do
        current_mode=$(iw dev ${interfaces[item_number]} info | grep type | awk '{print $2}')
        printf "$item_number: $current_mode ${interfaces[item_number]}\n"
        item_number=$((item_number + 1))
    done
    printf "\n"

    read menu_choice

    case "$menu_choice" in
    q|Q)
        printf "Exiting.\n"
        break
        ;;

    a|A)
        printf "'All' not implemented yet.\n"
        ;;

    0|1|2|3|4|5|6|7|8|9)
        current_iface=${interfaces[menu_choice]}
        iface_mode=$(iw dev $current_iface info | grep type | awk '{print $2}')

        # if the current mode is managed, switch to monitor and rename
        # else if the current mode is monitor, switch back to original
        # name and mac and managed mode

        case $iface_mode in
            managed)
                new_iface="wlan$menu_choice"
                printf "$current_iface"
                printf "$new_iface"

                sudo ip link set $current_iface down
                sudo ip link set $current_iface name $new_iface
                sudo macchanger -r $new_iface
                sudo ip link set $new_iface up
                sudo airmon-ng start $new_iface
                ;;
            monitor)
                sudo airmon-ng stop $current_iface
                sudo ip link set $current_iface down
                sudo ip macchanger -p $current_iface
                sudo ip link set $current_iface up
                ;;
        esac
        ;;

    *)
        printf "$menu_choice is an invalid option."
        break
        ;;

    esac

done
