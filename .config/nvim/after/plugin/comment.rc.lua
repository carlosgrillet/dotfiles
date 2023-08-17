local status, comment = pcall(require, "Comment")
if (not status) then return end


comment.setup({
  padding = true, -- Add sspacke b/w comment and line
  sticky = true, -- Cursor stay at its position
  ignore = '^$', -- Ignore comments in empty lines
  toggler = {
    line = '<C-\\>',
    block = 'gbc',
  },  
  opleader = {
    line = '<C-\\>',
    block = 'gb',
  },  
})
