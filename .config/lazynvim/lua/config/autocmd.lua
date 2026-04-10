-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Return to start point on leave visual
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "n:v", "n:V", "n:\x16" },
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_mark(0, "V", pos[1], pos[2], {})
  end,
})

-- Set fold method
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if require("nvim-treesitter.parsers").has_parser() then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
      vim.opt.foldmethod = "syntax"
    end
  end,
})
