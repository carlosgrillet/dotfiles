local status, ts = pcall(require, "nvim-treesitter")
if not status then
  vim.notify("Failed to load nvim-treesitter")
  return
end

ts.setup({
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
    "terraform",
    "vimdoc",
    "yaml",
  },
})

-- Enable treesitter highlighting for languages without built-in support
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Textobjects (requires nvim-treesitter-textobjects on main branch)
local ts_ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
if ts_ok then
  textobjects.setup({
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
  })
end
