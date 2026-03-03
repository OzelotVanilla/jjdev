#region jjdev

jjdev()
{
    local session="jjdev__$(basename "$PWD")"

    if ! tmux has-session -t "$session" 2>/dev/null; then
      tmux new-session -d -s "$session" -c "$PWD"
      tmux split-window -h -t "$session" -c "$PWD"
      tmux send-keys -t "$session:0.1" "watchexec --quiet --clear --restart --watch=.jj/repo/op_heads/heads --ignore-nothing --wrap-process=none -- jj --ignore-working-copy log" C-m
      tmux select-pane -t "$session:0.0"
    fi

    tmux attach -t "$session"
}

jjexit()
{
    local session="jjdev__$(basename "$PWD")"

    if tmux has-session -t "$session" 2>/dev/null; then
      tmux kill-session -t "$session"
      echo "Killed tmux session: $session"
    else
      echo "No tmux session found: $session"
    fi
}

#endregion jjdev