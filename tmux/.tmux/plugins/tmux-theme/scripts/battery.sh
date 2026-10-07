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
            echo 'discharging'
            ;;
        charging | Charging)
            echo 'charging'
            ;;
        charged | high | Full | finishingcharge)
            echo 'charged'
            ;;
        *)
            echo 'ac'
            ;;
    esac
}

# Material Design battery icons (nf-md-battery_*), index = percent rounded up to tens
discharging_icons=('󰂎' '󰁺' '󰁻' '󰁼' '󰁽' '󰁾' '󰁿' '󰂀' '󰂁' '󰂂' '󰁹')
charging_icon=''

main() {
    bat_stat=$(battery_status)
    bat_perc=$(battery_percent)
    bat_perc_num=${bat_perc%%%}

    # desktop with no battery percent, only AC power
    if [ -z "$bat_perc_num" ]; then
        echo "$charging_icon"
        return
    fi

    level=$(((bat_perc_num + 9) / 10))
    [ $level -gt 10 ] && level=10

    case $bat_stat in
        discharging) bat_label=${discharging_icons[$level]} ;;
        *) bat_label=$charging_icon ;;
    esac

    echo "$bat_label $bat_perc"
}

#run main driver program
main
