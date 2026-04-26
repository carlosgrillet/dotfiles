return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = { delete = { icon = '┃' } },
            signs_staged = { delete = { text = '┃' } },
            signcolumn = true,
            numhl = true,
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')
                vim.keymap.set('n', 'Sh', gitsigns.preview_hunk, { buffer = bufnr })
                vim.keymap.set('n', 'sh', gitsigns.stage_hunk, { buffer = bufnr })
                vim.keymap.set('n', 'Rh', gitsigns.reset_hunk, { buffer = bufnr })
                vim.keymap.set('n', 'gb', gitsigns.blame_line, { buffer = bufnr })
                vim.keymap.set('n', 'vih', gitsigns.select_hunk, { buffer = bufnr })
            end,
        }
    },
    {
        "wakatime/vim-wakatime",
        lazy = false,
        opts = {
            status_bar_enabled = false,
        },
    },
}
