Set-Alias v nvim
Set-Alias python3 python

$Env:MANPATH = mandoc

Function lsusb {Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' }}

oh-my-posh init pwsh | Invoke-Expression
# oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/jandedobbeleer.omp.json' | Invoke-Expression
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/nordtron.omp.json' | Invoke-Expression

$env:FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border'

function ff{
    nvim $(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
    }

function mman{
    param (
          $ParameterName
      )
    mandoc $ParameterName | nvim +Man!
    }
