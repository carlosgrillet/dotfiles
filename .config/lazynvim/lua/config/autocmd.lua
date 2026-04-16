-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = '*',
    command = "set nopaste"
})

-- Return to start point on leave visual
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = { "n:v", "n:V", "n:\x16" },
    callback = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_buf_set_mark(0, "V", pos[1], pos[2], {})
    end,
})

-- Set fold method
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if require("nvim-treesitter.parsers").has_parser() then
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        else
            vim.opt.foldmethod = "syntax"
        end
    end,
})

-- C styling for Kernel development
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = { "*.c", "*.h", "*.S", "*.s" },
    desc = "Linux kernel coding style",
    callback = function()
        local opt       = vim.opt
        opt.tabstop     = 8
        opt.shiftwidth  = 8
        opt.softtabstop = 8
        opt.expandtab   = false
        opt.textwidth   = 80
        opt.list        = true
        opt.listchars   = {
            tab   = "  ",
            trail = " ",
        }
        opt.formatoptions:remove("t")
        opt.formatoptions:append("o")
        opt.formatoptions:append("q")
        opt.formatoptions:append("n")
        opt.cindent    = true
        opt.cinoptions = ":0,l1,t0,g0,(0"
        opt.spelllang  = "en_us"
        opt.spell      = false

        -- Highlight trailing whitespace
        vim.cmd("highlight TrailingWhitespace ctermbg=red guibg=#FF0000")
        vim.cmd("match TrailingWhitespace /\\s\\+$/")

        -- Highlight overlong lines
        vim.cmd("highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929")
        vim.cmd("2match OverLength /\\%81v.\\+/")
    end,
})
