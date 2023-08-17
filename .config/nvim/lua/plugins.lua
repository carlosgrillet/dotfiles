local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Packet manager for neovim
  -- Theme, colors and icons
  use { 'svrana/neosolarized.nvim', requires = { 'tjdevries/colorbuddy.nvim' } }
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'norcalli/nvim-colorizer.lua' -- Color highlighter
  -- Completion tools
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'saadparwaiz1/cmp_luasnip' -- nvim-cmp source for luasnip
  use 'L3MON4D3/LuaSnip'
  use 'github/copilot.vim'
  -- Language server tools
  use 'neovim/nvim-lspconfig' -- LSP
  use 'williamboman/nvim-lsp-installer' -- Allow you to manage LSP servers
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
  use 'williamboman/mason.nvim' -- UI for Mange LSP servers
  use 'williamboman/mason-lspconfig.nvim'
  use({
    'glepnir/lspsaga.nvim', -- LSP UIs
    event = 'BufRead',
    config = function()
      require('lspsaga').setup({})
    end,
    dependices = { {'nvim-tree/nvim-web-devicons'} }
  })
  -- Nvim tools
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({
      with_sync = true
    }) end,
  }
  use 'nvim-telescope/telescope.nvim' -- High extendable fuzzy finder
  use 'nvim-telescope/telescope-file-browser.nvim' -- File fuzzy finder
  use 'windwp/nvim-autopairs' -- Auto pair plugin
  use 'windwp/nvim-ts-autotag' -- Autoclose and autorename html tags
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'akinsho/nvim-bufferline.lua'
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse
  use 'sindrets/diffview.nvim' -- For git diff view
  use 'tpope/vim-surround' -- For operations surrounding
  use 'tpope/vim-repeat' -- To repeat surround operations
  use 'mattn/emmet-vim'
  use {
    "Djancyp/better-comments.nvim", -- For better comment lines
    config = function() require("better-comment").Setup({})
    end
  } 
  use 'numToStr/Comment.nvim' -- For comment multiple lines
end)
