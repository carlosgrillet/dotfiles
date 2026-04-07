-- Save on W
vim.api.nvim_create_user_command('W', 'w', { nargs = 0 })

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

-- Linux Kernel Coding Style for Neovim
-- Source: https://www.kernel.org/doc/html/latest/process/coding-style.html
local kernel_augroup = vim.api.nvim_create_augroup("LinuxKernelStyle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = kernel_augroup,
  pattern = { "*.c", "*.h", "*.cpp", "*.cc", "*.cxx", "*.hpp", "*.S", "*.s" },
  callback = function()
    local opt       = vim.opt

    opt.tabstop     = 8
    opt.shiftwidth  = 8
    opt.softtabstop = 8
    opt.expandtab   = false
    opt.textwidth   = 79
    opt.colorcolumn = "80"
    opt.list        = true
    opt.listchars   = {
      tab      = "».",
      trail    = ".",
      extends  = ">",
      precedes = "<",
      nbsp     = "+",
    }
    opt.wrap        = false
    opt.number      = true
    opt.signcolumn  = "yes"
    opt.formatoptions:remove("t")
    opt.formatoptions:append("r")
    opt.formatoptions:append("o")
    opt.formatoptions:append("q")
    opt.formatoptions:append("n")
    opt.cindent    = true
    opt.cinoptions = ":0,l1,t0,g0,(0"
    opt.spelllang  = "en_us"
    opt.spell      = false
  end,
})

-- Highlight trailing whitespace (forbidden in kernel patches)
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = kernel_augroup,
  pattern = { "*.c", "*.h", "*.cpp", "*.cc", "*.cxx", "*.hpp", "*.S", "*.s" },
  desc = "Highlight trailing whitespace",
  callback = function()
    vim.cmd("highlight TrailingWhitespace ctermbg=red guibg=#FF0000")
    vim.cmd("match TrailingWhitespace /\\s\\+$/")
  end,
})

-- Highlight characters beyond column 80
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = kernel_augroup,
  pattern = { "*.c", "*.h", "*.cpp", "*.cc", "*.cxx", "*.hpp", "*.S", "*.s" },
  desc = "Highlight overlong lines",
  callback = function()
    vim.cmd("highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929")
    vim.cmd("2match OverLength /\\%81v.\\+/")
  end,
})
