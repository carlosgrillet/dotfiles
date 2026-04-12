return {
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
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
            end,
        },
        config = function(_, opts)
            require("solarized-osaka").setup(opts)
            vim.cmd([[colorscheme solarized-osaka]])
        end,
    },
}
