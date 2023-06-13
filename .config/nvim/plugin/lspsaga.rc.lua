local status, saga = pcall(require, "lspsaga")
if (not status) then return end

<<<<<<< HEAD
=======
local keymap = vim.keymap.set

saga.setup({})

>>>>>>> 297ef2862d02a97e12a51cb469b30aa57ef53e71
local opts = { noremap = true, silent = true }

keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
keymap('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
keymap('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
