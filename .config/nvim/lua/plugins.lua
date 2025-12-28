local status, packer = pcall(require, "packer")
if not status then
	vim.notify("Failed to load packer")
  return
end

vim.cmd([[packadd packer.nvim]])

packer.startup({
  function(use)
    use("wbthomason/packer.nvim")               -- Packet manager for neovim

    -- Core tools
    use("neovim/nvim-lspconfig")                -- LSP
    use("mfussenegger/nvim-lint")               -- Linter
    use("mhartington/formatter.nvim")           -- Formatter
    use("williamboman/nvim-lsp-installer")      -- Allow you to manage LSP servers
    use("williamboman/mason.nvim")              -- UI for Mange LSP servers
    use("williamboman/mason-lspconfig.nvim")    -- Hook for Mason to work with lspconfig
    use("nvim-neotest/nvim-nio")                -- Required by nvim-dap-ui

    -- Completion tools
    use("hrsh7th/nvim-cmp")                     -- Completion
    use("hrsh7th/cmp-buffer")                   -- nvim-cmp source for buffer words
    use("hrsh7th/cmp-nvim-lsp")                 -- nvim-cmp source for neovim's built-in LSP
    use("L3MON4D3/LuaSnip")                     -- Snipet engine for nvim
    use("saadparwaiz1/cmp_luasnip")             -- Snipet engine for nvim

    -- Nvim tools
    use({"nvim-treesitter/nvim-treesitter", branch = "master"})      -- Parser generator
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("ibhagwan/fzf-lua")                     -- Faster Fuzzy Finder
    use("windwp/nvim-autopairs")                -- Auto pair plugin
    use("kylechui/nvim-surround")               -- For operations surrounding
    use("nvim-tree/nvim-tree.lua")              -- File explorer
    use("wakatime/vim-wakatime")                -- For time mesurement
    use("lewis6991/gitsigns.nvim")              -- Buffer integration wit Git

    -- Theme, colors and icons
    use("nvim-lualine/lualine.nvim")            -- Statusline
    use("nvim-lua/plenary.nvim")                -- Common utilities
    use("folke/noice.nvim")                     -- Enhanced UI
    use("craftzdog/solarized-osaka.nvim")    		-- Theme
    use("MunifTanjim/nui.nvim")                 -- Required by noice
    use("rcarriga/nvim-notify")                 -- Required by noice
    use("kyazdani42/nvim-web-devicons")         -- Icons
    use("onsails/lspkind-nvim")                 -- VSCode like pictograms for LSP

  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
