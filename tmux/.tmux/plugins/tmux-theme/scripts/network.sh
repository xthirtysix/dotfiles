#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

HOSTS="google.com github.com example.com"

get_ssid() {
  # Check OS
  case $(uname -s) in
    Linux)
      SSID=$(iw dev | sed -nr 's/^\t\tssid (.*)/\1/p')
      if [ -n "$SSID" ]; then
        printf '%s' "$SSID"
      else
        echo 'Ethernet'
      fi
      ;;

    Darwin)
        # Получаем SSID с помощью sudo
        SSID=$(ipconfig getsummary en0 2>/dev/null | awk -F ': ' '/ SSID/ {print $2}')
    
        if [ -n "$SSID" ] && [ "$SSID" != "<redacted>" ]; then
            printf '%s' "$SSID"
        else
            echo 'No Wi-Fi'
        fi
        ;;

    CYGWIN*|MINGW32*|MSYS*|MINGW*)
      # leaving empty - TODO - windows compatability
      ;;

    *)
      ;;
  esac

}

main() {
  network="Offline"
  ICON="󰖩"

  for host in $HOSTS; do
    if ping -q -c 1 -W 1 $host &>/dev/null; then
      network="$(get_ssid)"
      break
    fi
  done

  echo "$ICON  $network"
}

#run main driver function
main
