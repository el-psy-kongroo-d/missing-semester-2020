#!/usr/bin/env bash
# job control ex 2 — wait for ANY pid, not just children of this shell.
# `wait` refuses non-children; `kill -0` pings any pid (exit 0 = alive).

pidwait() {
    local pid=$1
    printf 'pidwait: watching pid %s ' "$pid"
    while kill -0 "$pid" 2> /dev/null; do
        printf '.'
        sleep 1
    done
    printf '\npidwait: pid %s finished\n' "$pid"
}

[[ $# -eq 1 ]] || { echo "usage: $0 <pid>" >&2; exit 1; }
pidwait "$1"
