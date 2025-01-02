#!/usr/bin/env bash

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR=$current_dir
tmux set-environment -g "@theme-root" "$ROOT_DIR"

$current_dir/scripts/theme.sh
