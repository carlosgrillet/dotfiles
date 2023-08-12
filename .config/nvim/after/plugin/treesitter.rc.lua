local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  -- to avoid errors run sudo apt install g++
  ensure_installed = {
    'python',
    'lua',
  },
  autotag = {
    enable = true,
  },
}

--run TSUpdateSync when having problems with tree-sitter
