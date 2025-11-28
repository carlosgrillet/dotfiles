local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("Failed to load nvim-treesitter") return
end

ts.setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = {},
  },
  -- to avoid errors run sudo apt install g++
  --run TSUpdateSync when having problems with tree-sitter
  ensure_installed = {
    "bash",
    "c",
    "diff",
    "go",
    "hcl",
    "html",
    "json",
    "lua",
    "python",
    "regex",
    "vimdoc",
    "yaml",
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["io"] = "@class.inner",
        ["ao"] = "@class.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
      },
    },
  }
})
