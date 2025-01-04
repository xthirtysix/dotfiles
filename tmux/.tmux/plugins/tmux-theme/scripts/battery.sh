#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $current_dir/utils.sh

linux_acpi() {
    arg=$1
    BAT=$(ls -d /sys/class/power_supply/*)
    if [ ! -x "$(which acpi 2>/dev/null)" ]; then
        case "$arg" in
            status)
                cat $BAT/status
                ;;

            percent)
                cat $BAT/capacity
                ;;

            *) ;;
        esac
    else
        case "$arg" in
            status)
                acpi | cut -d: -f2- | cut -d, -f1 | tr -d ' '
                ;;
            percent)
                acpi | cut -d: -f2- | cut -d, -f2 | tr -d '% '
                ;;
            *) ;;
        esac
    fi
}

battery_percent() {
    # Check OS
    case $(uname -s) in
        Linux)
            percent=$(linux_acpi percent)
            [ -n "$percent" ] && echo " $percent"
            ;;

        Darwin)
            echo $(pmset -g batt | grep -Eo '[0-9]?[0-9]?[0-9]%')
            ;;

        FreeBSD)
            echo $(apm | sed '8,11d' | grep life | awk '{print $4}')
            ;;

        CYGWIN* | MINGW32* | MSYS* | MINGW*)
            # leaving empty - TODO - windows compatability
            ;;

        *) ;;
    esac
}

battery_status() {
    # Check OS
    case $(uname -s) in
        Linux)
            status=$(linux_acpi status)
            ;;

        Darwin)
            status=$(pmset -g batt | sed -n 2p | cut -d ';' -f 2 | tr -d " ")
            ;;

        FreeBSD)
            status=$(apm | sed '8,11d' | grep Status | awk '{printf $3}')
            ;;

        CYGWIN* | MINGW32* | MSYS* | MINGW*)
            # leaving empty - TODO - windows compatability
            ;;

        *) ;;
    esac

    case $status in
        discharging | Discharging)
            echo ''
            ;;
        high | Full)
            echo ''
            ;;
        charging | Charging)
            echo 'AC'
            ;;
        *)
            echo 'AC'
            ;;
    esac
}

main() {
    bat_label=''
    bat_stat=$(battery_status)
    bat_perc=$(battery_percent)
    bat_perc_num=${bat_perc%%%}

    if [ -z "$bat_stat" ]; then # Test if status is empty or not
        if [ "$bat_perc_num" -le 10 ]; then
            bat_label=''
        elif [ "$bat_perc_num" -le 25 ]; then
            bat_label=''
        elif [ "$bat_perc_num" -le 50 ]; then
            bat_label=''
        elif [ "$bat_perc_num" -le 75 ]; then
            bat_label=''
        fi
        echo "$bat_label  $bat_perc"
    elif [ -z "$bat_perc" ]; then # In case it is a desktop with no battery percent, only AC power
        echo ""
    else
        echo "  $bat_perc"
    fi
}

#run main driver program
main
