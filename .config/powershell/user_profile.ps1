# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr

# Import modules
Import-Module Terminal-Icons
Import-Module PSFzf


# Config modules
oh-my-posh init pwsh --config $env:USERPROFILE\.config\powershell\theme.omp.json | Invoke-Expression
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -BellStyle None 
Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

#functions
function Get-PublicIP(){
  try{
    (iwr -uri "ifconfig.me/ip").content
  }
  catch{
    write-host -ForegroundColor Red "Connection Error"
  }
}

function Get-PacketLoss($ip){
  while(1){
    ping -n 100 $ip |
    Select-String "[0-9]{1,3}% perdidos" | 
    foreach {$_.Matches.Value} | 
    foreach {"{0} - {1}" -f (Get-Date),$_}
  }
}

function Get-Latency($ip){
  if ($ip -eq "") {
      return 0
  }
  "{0}`t`t{1}`t{2}" -f "Time","RTT","%loss"
  while(1) {
      $latencia = ping -n 100 $ip 
      $Media = $latencia | Select-String "Media = [0-9]{1,4}ms" | 
      foreach {$_.Matches.Value} |
      Select-String "[0-9]{1,4}" |
      foreach {$_.Matches.Value}
      $loss = $latencia | Select-String "[0-9]{1,3}% perdidos" | 
      foreach {$_.Matches.Value} | 
      Select-String "[0-9]{1,4}" |
      foreach {$_.Matches.Value}

      "{0}`t{1}`t{2}" -f (Get-Date -Format "HH:mm:ss"),$media,$loss
  }
}

function router(){
  ssh cgrillet@10.250.0.1
}

function vimdir(){
  cd $env:LOCALAPPDATA/nvim
  vim . 
}

function dockerls(){
  docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.State}}\t{{.RunningFor}}"
}
