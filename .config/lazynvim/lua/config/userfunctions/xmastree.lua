local M = {}

---Sort lines by display width.
---@param lines string[]
---@param reverse boolean  true = longest first (reverse xmas tree)
---@return string[]
local function xmas_sort(lines, reverse)
    local items = {}
    for i, line in ipairs(lines) do
        items[i] = {
            line = line,
            -- Display width, not bytes: handles tabs and multibyte chars.
            -- Trailing whitespace shouldn't affect the shape.
            width = vim.fn.strdisplaywidth((line:gsub("%s+$", ""))),
            idx = i,
        }
    end

    table.sort(items, function(a, b)
        if a.width ~= b.width then
            if reverse then
                return a.width > b.width
            end
            return a.width < b.width
        end
        -- table.sort isn't stable; tie-break on original position.
        return a.idx < b.idx
    end)

    return vim.tbl_map(function(it) return it.line end, items)
end

---@param first integer 1-based, inclusive
---@param last integer  1-based, inclusive
---@param reverse boolean
function M.sort_range(first, last, reverse)
    local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, true)
    vim.api.nvim_buf_set_lines(0, first - 1, last, true, xmas_sort(lines, reverse))
end

-- Operator support: works with motions (ip, 5j, …), visual mode, and dot-repeat.
local reverse_op = false

function M.opfunc(_)
    local first = vim.api.nvim_buf_get_mark(0, "[")[1]
    local last = vim.api.nvim_buf_get_mark(0, "]")[1]
    M.sort_range(first, last, reverse_op)
end

---@param reverse boolean
---@return string
function M.operator(reverse)
    reverse_op = reverse
    vim.o.operatorfunc = "v:lua.require'config.userfunctions.xmastree'.opfunc"
    return "g@"
end

function M.setup()
    vim.api.nvim_create_user_command("XmasTree", function(opts)
        M.sort_range(opts.line1, opts.line2, opts.bang)
    end, {
        range = true,
        bang = true,
        desc = "Sort lines in xmas tree. Use ! to reverse xmas tree",
    })

    vim.keymap.set({ "n", "x" }, "<leader>st", function() return M.operator(false) end,
        { expr = true, desc = "Xmas tree sort" })
    vim.keymap.set({ "n", "x" }, "<leader>sT", function() return M.operator(true) end,
        { expr = true, desc = "Reverse xmas tree sort" })
end

return M
