# PROMPT
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt Paradox

# SET THEME ON LOAD
oh-my-posh --init --shell pwsh --config C:\Users\Carlos\.config\powershell\carlos.omp.json | Invoke-Expression

# ALIAS
Set-Alias vim nvim
Set-Alias g git
Set-Alias ll ls
Set-Alias la 'ls -Hidden'
Set-Alias grep findstr
Set-Alias less 'C:\Program Files\Git\bin\less.exe'

