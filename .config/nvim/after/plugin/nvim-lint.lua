local status, lint = pcall(require, "lint")
if not status then
	vim.notify("Failed to load lint")
	vim.notify("Failed to load nvim-lint")
	return
end

lint.linters_by_ft = {
  python = {'pylint'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
