#!/usr/bin/env bash

CURRENT_FILE="${BASH_SOURCE[0]}"
CURRENT_DIR="$(dirname -- "$(readlink -f -- "$0")")"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

source "$ROOT_DIR/scripts/utils.sh"

available_plugins="battery git network ssh-session network-vpn weather time spotify-tui synchronize-panes"

get_plugin_title() {
    local plugin=$1
    local active_plugins=$(get_tmux_option "@theme-plugins" "")
    if [[ $active_plugins == *"$plugin"* ]]; then
        echo "Hide $plugin"
    else
        echo "Show $plugin"
    fi
}

render() {
    tmux display-menu -T "#[align=centre fg=green]Plugins" -x R -y P \
        "" \
        "" \
        "$(get_plugin_title "battery")" A "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin battery; source $CURRENT_FILE" \
        "$(get_plugin_title "git")" C "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin git; source $CURRENT_FILE" \
        "$(get_plugin_title "network")" G "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin network; source $CURRENT_FILE" \
        "$(get_plugin_title "ssh-session")" J "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin ssh-session; source $CURRENT_FILE" \
        "$(get_plugin_title "network-vpn")" L "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin network-vpn; source $CURRENT_FILE" \
        "$(get_plugin_title "weather")" M "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin weather; source $CURRENT_FILE" \
        "$(get_plugin_title "time")" N "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin time; source $CURRENT_FILE" \
        "$(get_plugin_title "spotify-tui")" P "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin spotify-tui; source $CURRENT_FILE" \
        "$(get_plugin_title "synchronize-panes")" S "run -b 'source #{@theme-root}/scripts/actions.sh toggle_plugin synchronize-panes; source $CURRENT_FILE" \
        "" \
        "<-- Back" b "run -b 'source #{@theme-root}/menu_items/main.sh" \
        "Close menu" q ""
}

render
