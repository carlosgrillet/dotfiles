vim.scriptencoding = "utf-8"

vim.opt.autoindent = true
vim.opt.background = "dark"
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.backup = false
vim.opt.backupskip = { "/tmp/*" }
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.fillchars = { eob = " " }
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.formatoptions:append { "r" }
vim.opt.gdefault = true
vim.opt.guicursor = "n-v-c-i:Block"
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.isfname:remove("=")
vim.opt.laststatus = 2
vim.opt.mouse = ""
vim.opt.path:append { "**" }
vim.opt.pumblend = 0
vim.opt.scrolloff = 8
vim.opt.shell = "bash"
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("I")
vim.opt.showcmd = true
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.undodir = vim.fn.expand("~/.vim/undo")
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"
vim.opt.wildignore:append { "*/node_modules/*", "*/.git/*" }
vim.opt.wildoptions = "pum"
vim.opt.winblend = 0
vim.opt.winborder = "rounded"
vim.opt.wrap = false

vim.wo.number = true
vim.wo.relativenumber = true

