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

-- Start Treesitter and set fold method
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
        if lang and pcall(vim.treesitter.language.inspect, lang) then
            local ok = pcall(vim.treesitter.start)
            if not ok then
                vim.wo.foldmethod = "syntax"
                return
            end

            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        else
            vim.wo.foldmethod = "syntax"
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

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = { "*.go", "*.rs", "*.py", "*.lua" },
    desc = "Highlight trailing whitespace",
    callback = function()
        vim.cmd("highlight TrailingWhitespace ctermbg=red guibg=#FF0000")
        vim.cmd("match TrailingWhitespace /\\s\\+$/")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitsendemail", "mail", "email" },
    desc = "Set colorcolumn and textwidth to 75",
    callback = function()
        local opt       = vim.opt
        opt.colorcolumn = "75"
        opt.shiftwidth  = 2
        opt.textwidth   = 75
        opt.tabstop     = 2
    end,
})
