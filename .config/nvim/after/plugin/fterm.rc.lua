local status, fterm = pcall(require, "FTerm")
if (not status) then return end

fterm.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

local gitgui = fterm:new({
  ft = 'fterm_gitui',
  cmd = 'gitui'
})

vim.keymap.set('n', ';c', 
  function()
    fterm.open() -- Opens the therminal windows
  end)

vim.keymap.set('n', ';d',
  function()
    gitgui:toggle()
  end)
