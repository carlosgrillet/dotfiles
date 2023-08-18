# dotfiles
These are some of my configurations. **Warning**: Don’t blindly use my settings unless you know what are you configuring

Minimalistic terminal
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/c4176c32-4b65-48ec-8836-90db6c5b3699)

Git diffview
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/ca72082c-4629-4c06-843a-486d3bef1def)

Telescope fuzzi finder
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/7872c0a3-cf14-49a6-ac86-89372fc8fe44)

Mason nvim LSP server manager
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/e681e5c7-45f4-4764-8481-b9d20f7ea098)

Text suggestions and autcompletion
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/43cec12b-7058-4ddc-ba5c-ac0b16ef63a8)



## Powershell setup
- [Scoop](https://scoop.sh/) - Windows package manager
- [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
- [Terminal Icons](https://github.com/devblackops/Terminal-Icons) - Folder and file icons
- [PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/) - Cmdlets for customizing the editing environment, used for autocompletion
- [Git for Windows](https://gitforwindows.org/)

<details>
<summary>Installing and configuring</summary>

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm get.scoop.sh | iex
scoop install curl sudo jq
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.config/powershell" -Target "path/to/dotfiles/.config/powershell"
# Edit the file Documents\PowerShell\Microsoft.PowerShell_profile.ps1 and add this
. $env:USERPROFILE\.config\powershell\user_profile.ps1
# write and quit
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Install-Module -Name PSFzf -Scope CurrentUser -Force
```
</details>

## Neovim setup

### [Neovim](https://github.com/neovim/neovim/releases/)

Windows:
```powershell
scoop install neovim gcc
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA/nvim" -Target "path/to/dotfiles/.config/nvim"
```

Linux:
```bash
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xvzf nvim-linux64.tar.gz
sudo mv nvim-linux64 /bin
sudo ln -s /bin/nvim-linux64/bin/nvim /bin/nvim
ln -s path/to/dotfiles/.config/nvim ~/.config/nvim
```

### [Packer](https://github.com/wbthomason/packer.nvim) - Plugin manager

Windows:
```powershell
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```

Linux:
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### [Node](https://nodejs.org/en/) - To install neovim packages with npm

Windows:
```powershell
scoop install nvm
nvm install latest
nvm use latest
```

Linux:
```bash
sudo apt install npm
sudo npm install -g n
sudo n latest
```
