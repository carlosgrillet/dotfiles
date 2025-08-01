local status, formatter = pcall(require, "formatter")
if not status then
	vim.notify("Failed to load formatter")
	return
end

formatter.setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    go = { function() return {exe = "gofmt", args = {"-w"}, stdin = true} end },
    hcl = { function() return { exe = "hclfmt", args = { "--" }, stdin = true, } end, },
    json = { function() return { exe = "prettier", args = {"--parser=json", "--no-bracket-spacing", "--print-width", "80"}, stdin = true } end },
    lua = { function() return { exe = "stylua", args = { "--search-parent-directories", "--stdin-filepath", vim.api.nvim_buf_get_name(0), "-" }, stdin = true, } end, },
    python = { function() return {exe = "black", args = {"-q", "-"}, stdin = true} end },
    terraform = { function() return {exe = "terraform", args = {"fmt", "-"}, stdin = true} end },
    yaml = { function() return {exe = "prettier", args = {"--parser=yaml"}, stdin = true} end },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    }
  }
}
