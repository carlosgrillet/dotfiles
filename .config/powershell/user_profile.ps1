# PROMPT
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt Paradox

# SET THEME ON LOAD
oh-my-posh --init --shell pwsh --config C:\Users\Carlos\.config\powershell\carlos.omp.json | Invoke-Expression

# ICONS
Import-Module -Name Terminal-Icons

# ALIAS
#function nvimcfg {nvim -u $HOME\.config\nvim\init.vim -}
#Set-Alias vim nvimcfg

Set-Alias vim nvim
Set-Alias g git
Set-Alias ll ls
Set-Alias grep findstr
