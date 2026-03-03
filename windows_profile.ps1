#region jjdev

# If your jj does not auto-complete, uncomment the following line.
#jj util completion power-shell | Out-String | Invoke-Expression

function jjdev
{
    $session = "jjdev__$(Split-Path -Leaf (Get-Location))"

    $hasWt = Get-Command wt -ErrorAction SilentlyContinue

    if ($hasWt)
    {
        wt -w 0 `
          new-tab -d . pwsh -NoExit `
          `; split-pane -V -d . pwsh -NoExit -Command `
          "watchexec --quiet --clear --restart --watch .jj/repo/op_heads/heads --ignore-nothing --wrap-process=none -- jj --ignore-working-copy log" `
          `; move-focus left
    }
    else
    {
        watchexec --quiet --clear --restart --watch .jj/repo/op_heads/heads --ignore-nothing --wrap-process=none -- jj --ignore-working-copy log
    }
}

function jjexit
{
    exit
}

# Alias for jj command.
#Set-Alias jjst jj -Option AllScope
#function jjll { jj log @args }
#function jjls { jj log -s @args }
#function jjbk { jj bookmark @args }
#function jjrb { jj rebase @args }
#function jjed { jj edit @args }

#endregion jjdev