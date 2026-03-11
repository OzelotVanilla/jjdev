#!/usr/bin/env bash

jjdev__tmux_has_session()
{
    local session_name="$1"
    tmux has-session -t "$session_name" 2>/dev/null
}

jjdev__tmux_create_session()
{
    local session_name="$1"
    local root_dir="$2"
    local watch_command="$3"

    tmux new-session -d -s "$session_name" -c "$root_dir" "env JJDEV_SESSION=1 zsh"
    tmux split-window -h -t "$session_name" -c "$root_dir"
    printf 'DEBUG: sending watch command\n' >&2
    # tmux send-keys -t "${session_name}:0.1" "env JJDEV_SESSION=1 zsh -lc ${(q-)watch_command}" C-m
    tmux send-keys -t "${session_name}:0.1" "watchexec --quiet --clear --restart --watch=.jj/repo/op_heads/heads --ignore-nothing --wrap-process=none -- $watch_command" C-m
    tmux select-pane -t "${session_name}:0.0"
}

jjdev__tmux_attach_session()
{
    local session_name="$1"
    tmux attach -t "$session_name"
}

jjdev__main()
{
    local root_dir
    local session_name
    local watch_command

    jjdev__require_command jj
    jjdev__require_command tmux
    jjdev__require_command watchexec
    jjdev__require_jj_repo

    root_dir="$(jjdev__get_root_dir)"
    session_name="$(jjdev__get_session_name "$root_dir")"
    watch_command="$(jjdev__build_watch_command)"

    if ! jjdev__tmux_has_session "$session_name"; then
        jjdev__tmux_create_session "$session_name" "$root_dir" "$watch_command"
        # jjdev__tmux_create_session "$session_name" "$root_dir"
    fi

    jjdev__tmux_attach_session "$session_name"
}