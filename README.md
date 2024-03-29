# dotfiles
These are some of my configurations. **Warning**: Don’t blindly use my settings unless you know what are you configuring

Minimalistic terminal
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/c4176c32-4b65-48ec-8836-90db6c5b3699)

Git diffview
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/ca72082c-4629-4c06-843a-486d3bef1def)

Telescope fuzzy finder
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/7872c0a3-cf14-49a6-ac86-89372fc8fe44)

Mason nvim LSP server manager
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/e681e5c7-45f4-4764-8481-b9d20f7ea098)

Text suggestions and autcompletion
![image](https://github.com/carlosgrillet/dotfiles/assets/13719979/43cec12b-7058-4ddc-ba5c-ac0b16ef63a8)



## Powershell setup

**Ensure to have [Powershell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3) installed**

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
scoop install curl sudo jq
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Install-Module -Name PSFzf -Scope CurrentUser -Force
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.config/powershell" -Target "<path/to/dotfiles>/.config/powershell"
# Edit the file %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 and add this line
. $env:USERPROFILE\.config\powershell\user_profile.ps1
# Write and quit
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
# Now restart the terminal
```

- [Scoop](https://scoop.sh/) - Windows package manager
- [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
- [Terminal Icons](https://github.com/devblackops/Terminal-Icons) - Folder and file icons
- [PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/) - Cmdlets for customizing the editing environment, used for autocompletion
- [Git for Windows](https://gitforwindows.org/)



## Neovim setup

### [Node](https://nodejs.org/en/) - To install neovim tools with npm

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

### [Neovim](https://github.com/neovim/neovim/releases/)

Windows:
```powershell
scoop install neovim gcc
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA/nvim" -Target "<path/to/dotfiles>/.config/nvim"
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

#### Neovim plugins I use
- [Djancyp/better-comments.nvim](https://github.com/Djancyp/better-comments.nvim)
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [MunifTanjim/prettier.nvim](https://github.com/MunifTanjim/prettier.nvim)
- [akinsho/nvim-bufferline.lua](https://github.com/akinsho/nvim-bufferline.lua)
- [dinhhuy258/git.nvim](https://github.com/dinhhuy258/git.nvim)
- [github/copilot.vim](https://github.com/github/copilot.vim)
- [glepnir/lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim)
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [mattn/emmet-vim](https://github.com/mattn/emmet-vim)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
- [numToStr/Comment.nvi](https://github.com/numToStr/Comment.nvim)
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [nvim-telescope/telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [onsails/lspkind-nvim](https://github.com/onsails/lspkind-nvim)
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [svrana/neosolarized.nvim](https://github.com/svrana/neosolarized.nvim)
- [tpope/vim-repeat](https://github.com/tpope/vim-repeat)
- [tpope/vim-surround](https://github.com/tpope/vim-surround)
- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
- [williamboman/nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer)
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)

- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)



