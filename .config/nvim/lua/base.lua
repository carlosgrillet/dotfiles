vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'

vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.backup = false
vim.opt.backupskip = { '/tmp/*' }
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.encoding = 'utf-8'
vim.opt.expandtab = true
vim.opt.fileencoding = 'utf-8'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.formatoptions:append { 'r' }
vim.opt.guicursor = 'n-v-c-i:Block'
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.mouse = ''
vim.opt.path:append { '**' }
vim.opt.pumblend = 30
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.shell = 'zsh'
vim.opt.shiftwidth = 2
vim.opt.showcmd = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.undodir = vim.fn.expand('~/.vim/undo')
vim.opt.undofile = true
vim.opt.wildignore:append { '*/node_modules/*', '*/.git/*' }
vim.opt.wildoptions = 'pum'
vim.opt.winblend = 0
vim.opt.winborder = "rounded"
vim.opt.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true

-- Italic text
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})
