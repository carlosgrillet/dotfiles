local exec = vim.fn.executable

local executables = {
	'ripgrep',
	'npm',
	'python3',
	'node',
	'go',
}

for _, executable in ipairs(executables) do
  if not exec(executable) then
    print('ERROR: ' .. executable .. ' not installed')
  end
end
