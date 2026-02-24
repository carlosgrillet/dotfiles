return {
  {
    "folke/noice.nvim",
    opts = {
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
            winhighlight = "Normal:TelescopePromptNormal,FloatTitle:Title,FloatBorder:NonText",
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
            winhighlight = "Normal:CmpNormal,FloatBorder:NonContext",
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
            winhighlight = "Normal:CmpNormal,FloatBorder:TelescopePromptBorder",
          },
        },
      },
    }
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "powerline",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          "encoding",
          "filetype",
        },
        lualine_y = { "progress", { macro_recording, cond = function() return vim.fn.reg_recording() ~= "" end } },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { "mason" },
    }
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      max_width = function()
        return math.floor(vim.o.columns * 0.5)
      end,
      max_height = function()
        return math.floor(vim.o.lines * 0.3)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      fps = 60,
      stages = "fade",
      timeout = 500,
      render = "wrapped-compact",
    }
  },
}
