local exec = vim.fn.executable

if not exec('ripgrep') then
  print('ERROR: ripgrep not installed')
end

if not exec('npm') then
  print('ERROR: npm not installed')
end
