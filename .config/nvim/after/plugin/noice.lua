local status, noice = pcall(require, "noice")
if not status then
	vim.notify("Failed to load noice")
	return
end

noice.setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    format = {
      cmdline = { pattern = "^:", icon = "", lang = "vim", title = "" },
      search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex", title = " Search Down "},
      search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex", title = " Search Up "},
      filter = { pattern = {"^:%s*!", "^:%s*r!"}, icon = "$", lang = "bash", title = " Shell " },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      help = { pattern = {"^:%s*he?l?p?%s+", "^:%s*?%s+"}, icon = "" },
      input = { view = "cmdline_input", icon = "" },
    },
  },
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
})
