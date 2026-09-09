return {
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            terminal_colors = false,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
                comments = { italic = true },
                keywords = { italic = true },
                functions = { italic = true },
            },
            on_colors = function(c)
                c.bg_sidebar = "#002b36"
                c.hint = "#FA7334"
                c.error = c.red
                c.warning = c.yellow300
                c.info = c.cyan300
            end,
            on_highlights = function(hl, c)
                hl.NoiceCmdlinePopupBorder = { fg = c.cyan300 }
                hl.NoiceCmdlinePopup = { fg = "#c44a16" }
                hl.TabLine = { bg = c.none }
                hl.TabLineFill = { bg = c.none }
                hl.TabLineSel = { bg = c.none }
            end,
        },
        config = function(_, opts)
            require("solarized-osaka").setup(opts)
            vim.cmd([[colorscheme solarized-osaka]])
        end,
    },
}
