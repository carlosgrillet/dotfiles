local status, conform = pcall(require, "conform")
if not status then
	-- vim.notify("Failed to load conform") -- error in windows
	return
end

conform.setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		lua = { "stylua" },
		python = { "black", "isort" },
		json = { "prettierd" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
