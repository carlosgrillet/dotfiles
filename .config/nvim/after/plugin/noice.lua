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
      cmdline = { pattern = "^:", icon = "", lang = "vim", title = "" },
      search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex", title = " Search Down "},
      search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex", title = " Search Up "},
      filter = { pattern = {"^:%s*!", "^:%s*r!"}, icon = "", lang = "bash", title = " Shell " },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "󰢱", lang = "lua" },
      help = { pattern = {"^:%s*he?l?p?%s+", "^:%s*%?"}, icon = "󱔘" },
      input = { view = "cmdline_input", icon = "󰩮" },
    },
  },
  messages = {
    enabled = true,
    view = "notify",
    view_error = "notify",
    view_warn = "notify",
    view_history = "split",
    view_search = "virtualtext",
  },
  popupmenu = {
    enabled = true,
    backend = "nui",
    kind_icons = false,
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = {
      enabled = true,
      view = "hover",
    },
  },
  views = {
    cmdline_popup = {
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        width = "33%",
        height = "auto",
      },
      border = {
        style = "rounded",
      },
      filter_options = {},
      win_options = {
        winhighlight = "Normal:TelescopePromptNormal,FloatTitle:TelescopePromptTitle,FloatBorder:TelescopePromptBorder",
      },
    },
    notify = {
      size = {
        width = "30%"
      },
    },
    popupmenu = {
      relative = "editor",
      size = {
        width = "auto",
        height = "auto",
      },
      border = {
        style = "rounded",
        padding = { 0, 0 },
      },
      win_options = {
        winhighlight = "Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder",
      },
    },
    hover = {
      position = {
        row = "2",
        col = "0",
      },
      size = {
        max_height = 10,
        max_width = 50,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = "Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder",
      },
    },
  },
})
