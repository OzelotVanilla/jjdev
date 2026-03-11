#!/usr/bin/env bash

jjdev__require_command()
{
    local command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        printf '\033[31merror\033[0m: Required command not found: `%s`.\n' "$command_name" >&2
        return 1
    fi
}

jjdev__require_jj_repo()
{
    if [ ! -d ".jj" ]; then
        printf '\033[31merror\033[90m: Not inside a jj repository.\n' >&2
        return 1
    fi
}

jjdev__get_root_dir()
{
    pwd -P
}

jjdev__get_session_name()
{
    local root_dir="$1"
    local session_hash="$(printf "%s" "$root_dir" | shasum | awk '{print $1}' | cut -c1-12)"

    printf "jjdev__%s\n" "$session_hash"
}

jjdev__build_watch_command()
{
    # local default_jj_cmd_to_run="jj --ignore-working-copy log -r 'all()' -n 20"

    local watchexec_cmd="watchexec --quiet --clear --restart --watch=.jj/repo/op_heads/heads --ignore-nothing --wrap-process=none"
    # local jj_cmd="${1:-$default_jj_cmd_to_run}"
    local jj_cmd="jj --ignore-working-copy log"

    printf "%s -- %s" "$watchexec_cmd" "$jj_cmd"
}