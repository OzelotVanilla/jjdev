# jjdev
A command creating a split jujutsu (vcs) development environment in your terminal,
 while the left panel is terminal, the right side watches your changes and runs `jj log`.

## How to use ?

Final Target: In your terminal, input `jjdev` to open a split-view of terminal and `jj log`.
Use `jjexit` to exit.
`jjdev` will open the split view in current working directory.

To install `jj`, please refer to [this page](https://docs.jj-vcs.dev/latest/install-and-setup/).

### Linux/MacOS

1. Ensure [`tmux`](https://github.com/tmux/tmux/wiki) is installed.
   For MacOS, it can be easily installed by `brew install tmux` if you use [`homebrew`](https://brew.sh/).
2. Copy and paste [this](https://github.com/OzelotVanilla/jjdev/blob/main/linux_profile.sh) to your shell profile.
3. Do not forget to `source` it before `jjdev` !

### Windows

1. Ensure powershell is updated to `7.x` or above. If you have `winget`, use this to install.
   
```
winget install Microsoft.PowerShell
```

2. Edit profile:
   
```pwsh
# Run this to edit profile.
notepad $PROFILE

# If does not exists, create it first.
New-Item -ItemType File -Path $PROFILE -Force
# Then run it again.
notepad $PROFILE
```

3. Copy and paste [this](https://github.com/OzelotVanilla/jjdev/blob/main/windows_profile.ps1)
    to the notepad tab you just opened for profile.

4. Open a new tab of powershell and `jjdev` would be ready-to-go.