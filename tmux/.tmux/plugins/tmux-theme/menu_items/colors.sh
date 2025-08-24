#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

source "$ROOT_DIR/scripts/utils.sh"

render() {
    local theme=$(get_tmux_option "@theme-palette" "catpuccin")

    local rosepine_title="Rose Pine"

    case $theme in
        rosepine)
            rosepine_title="Rose Pine*"
            ;;
    esac

    tmux display-menu -T "#[align=centre fg=green]Colors" -x R -y P \
        "" \
        "" \
        "$rosepine_title" 1 "run -b '#{@theme-root}/scripts/actions.sh set_state_and_tmux_option theme rosepine" \
        "" \
        "<-- Back" b "run -b 'source #{@theme-root}/menu_items/main.sh" \
        "Close menu" q ""
}

render
