local status, packer = pcall(require, "packer")
if not status then
	vim.notify("Failed to load packer")
  return
end

vim.cmd([[packadd packer.nvim]])

packer.startup({
  function(use)
    use("wbthomason/packer.nvim")               -- Packet manager for neovim


    -- Nvim tools
    use("ibhagwan/fzf-lua")                     -- Faster Fuzzy Finder
    use("kylechui/nvim-surround")               -- For operations surrounding
    use("wakatime/vim-wakatime")                -- For time mesurement
    use("lewis6991/gitsigns.nvim")              -- Buffer integration wit Git
    use("nvim-treesitter/nvim-treesitter")      -- Parser generator * require GCC

    -- Theme, colors and icons
    use("nvim-lualine/lualine.nvim")            -- Statusline
    use("nvim-lua/plenary.nvim")                -- Common utilities
    use("craftzdog/solarized-osaka.nvim")   	-- Theme
    use("kyazdani42/nvim-web-devicons")         -- Icons

  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
