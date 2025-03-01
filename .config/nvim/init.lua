require('base')
require('maps')
require('plugins')
require('utils-software')

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_win = has "win32"

if is_win then
  require('utils-windows')
end
