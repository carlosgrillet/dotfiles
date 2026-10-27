-- Convert identifiers between naming conventions:
-- snake_case, camelCase, PascalCase, kebab-case, SCREAMING_SNAKE_CASE.

local M = {}

---@alias CaseStyle "snake"|"camel"|"pascal"|"kebab"|"screaming"

---Cycle order used when no explicit style is given.
---@type CaseStyle[]
M.order = { "snake", "camel", "pascal", "kebab", "screaming" }

---@param w string
---@return string
local function capitalize(w)
    return (w:gsub("^%l", string.upper))
end

---@type table<CaseStyle, fun(parts: string[]): string>
local joiners = {
    snake = function(p) return table.concat(p, "_") end,
    kebab = function(p) return table.concat(p, "-") end,
    screaming = function(p) return table.concat(p, "_"):upper() end,
    pascal = function(p) return table.concat(vim.tbl_map(capitalize, p)) end,
    camel = function(p)
        local out = { p[1] }
        for i = 2, #p do
            out[i] = capitalize(p[i])
        end
        return table.concat(out)
    end,
}

---Split an identifier into lowercase words.
---  "HTTPServerError" -> { "http", "server", "error" }
---  "ipv4Addr"        -> { "ipv4", "addr" }
---  "request timeout" -> { "request", "timeout" }
---@param s string
---@return string[]
local function split(s)
    s = s:gsub("(%l)(%u)", "%1 %2")  -- fooBar      -> foo Bar
        :gsub("(%d)(%u)", "%1 %2")   -- ipv4Addr    -> ipv4 Addr
        :gsub("(%u)(%u%l)", "%1 %2") -- HTTPServer  -> HTTP Server

    local parts = {}
    for w in s:gmatch("%w+") do
        parts[#parts + 1] = w:lower()
    end
    return parts
end

---Best-effort guess of the style `s` is currently in.
---@param s string
---@return CaseStyle
local function detect(s)
    if not s:find("%l") then return "screaming" end
    if s:find("%-") then return "kebab" end
    if s:find("_") then return "snake" end
    if s:find("^%u") then return "pascal" end
    if s:find("%u") then return "camel" end
    return "snake"
end

---Convert `s` to `style`, preserving leading/trailing `_` and `-`
---(so `_private` stays private and `__dunder__` survives).
---@param s string
---@param style CaseStyle
---@return string
function M.convert(s, style)
    local prefix, body, suffix = s:match("^([_%-]*)(.-)([_%-]*)$")
    local parts = split(body)
    if #parts == 0 then
        return s
    end
    return prefix .. joiners[style](parts) .. suffix
end

---Advance to the next style in M.order whose output actually differs
---from `s` (a single word like "foo" is both snake and camel).
---@param s string
---@return string out
---@return CaseStyle? style  the style that produced `out`; nil if unchanged
function M.cycle(s)
    local start = 1
    local current = detect(s)
    for i, style in ipairs(M.order) do
        if style == current then
            start = i
            break
        end
    end

    for k = 1, #M.order - 1 do
        local style = M.order[(start - 1 + k) % #M.order + 1]
        local out = M.convert(s, style)
        if out ~= s then
            return out, style
        end
    end
    return s, nil
end

---@class CaseSpan
---@field row integer 0-based line
---@field s   integer 0-based byte column, inclusive
---@field e   integer 0-based byte column, exclusive

---Identifier under the cursor. Unlike `<cword>`, this includes `-`
---so kebab-case words are picked up whole.
---@return CaseSpan?
local function word_under_cursor()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local ident = "[%w_%-]"

    local i = col + 1
    if not line:sub(i, i):match(ident) then
        return nil
    end

    local s, e = i, i
    while s > 1 and line:sub(s - 1, s - 1):match(ident) do
        s = s - 1
    end
    while e < #line and line:sub(e + 1, e + 1):match(ident) do
        e = e + 1
    end

    return { row = row - 1, s = s - 1, e = e }
end

---Span between two marks ('<,'> for a visual selection, '[,'] for an
---operator), restricted to a single line.
---@param first string mark name
---@param last string mark name
---@return CaseSpan?
local function mark_span(first, last)
    local srow, scol = unpack(vim.api.nvim_buf_get_mark(0, first))
    local erow, ecol = unpack(vim.api.nvim_buf_get_mark(0, last))
    if srow ~= erow then
        vim.notify("Case: selection must be on a single line", vim.log.levels.WARN)
        return nil
    end

    local line = vim.api.nvim_buf_get_lines(0, srow - 1, srow, true)[1]
    if #line == 0 then
        return nil
    end

    ecol = math.min(ecol, #line - 1)
    local e = ecol + 1 + vim.str_utf_end(line, ecol + 1)

    return { row = srow - 1, s = scol, e = e }
end

---Rename through the LSP when a server supports it.
---Set to false to always do a plain text edit.
M.use_lsp = true

---@param s string
---@return boolean
local function is_identifier(s)
    return s:match("^[%a_][%w_]*$") ~= nil
end

---@param old string
---@param new string
---@return boolean
local function should_use_lsp(old, new)
    if not M.use_lsp then
        return false
    end
    if not (is_identifier(old) and is_identifier(new)) then
        return false
    end
    return #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/rename" }) > 0
end

---@param span CaseSpan
---@param style CaseStyle?  nil = cycle to the next style
---@param lsp boolean       allow LSP rename (word targets only)
---@return CaseStyle? applied  the style actually applied, if any
local function apply(span, style, lsp)
    local text = vim.api.nvim_buf_get_text(0, span.row, span.s, span.row, span.e, {})[1]

    local out
    if style then
        out = M.convert(text, style)
    else
        out, style = M.cycle(text)
    end

    if out == text then
        return style
    end

    vim.api.nvim_win_set_cursor(0, { span.row + 1, span.s })

    if lsp and should_use_lsp(text, out) then
        vim.lsp.buf.rename(out)
    else
        vim.api.nvim_buf_set_text(0, span.row, span.s, span.row, span.e, { out })
    end
    return style
end


---@type CaseStyle?  nil = cycle
local op_style
---@type "word"|"range"
local op_target = "word"

---Called by Vim (via 'operatorfunc') on the initial press and on every `.`.
---@param kind "char"|"line"|"block"
function M.opfunc(kind)
    local span
    if op_target == "word" then
        span = word_under_cursor()
    elseif kind == "block" then
        vim.notify("Case: blockwise selections are not supported", vim.log.levels.WARN)
        return
    else
        span = mark_span("[", "]")
    end

    if not span then
        return
    end

    op_style = apply(span, op_style, op_target == "word") or op_style
end

---Expr-mapping entry point: store state, then hand Vim the `g@` keys.
---@param style CaseStyle?  nil = cycle
---@param target "word"|"range"
---@return string
function M.operator(style, target)
    op_style, op_target = style, target
    vim.o.operatorfunc = "v:lua.require'config.userfunctions.case'.opfunc"
    return target == "word" and "g@l" or "g@"
end

function M.setup()
    vim.api.nvim_create_user_command("Case", function(opts)
        local style = opts.args ~= "" and opts.args or nil
        if style and not joiners[style] then
            vim.notify(("Case: unknown style '%s'"):format(style), vim.log.levels.ERROR)
            return
        end

        local ranged = opts.range > 0
        local span
        if ranged then
            span = mark_span("<", ">")
        else
            span = word_under_cursor()
        end

        if span then
            apply(span, style, not ranged)
        end
    end, {
        nargs = "?",
        range = true,
        desc = "Convert identifier case (no argument = cycle)",
        complete = function(arglead)
            return vim.tbl_filter(function(s)
                return vim.startswith(s, arglead)
            end, M.order)
        end,
    })

    ---@param lhs string
    ---@param style CaseStyle?
    ---@param desc string
    local function map(lhs, style, desc)
        vim.keymap.set("n", lhs, function() return M.operator(style, "word") end,
            { expr = true, desc = desc })
        vim.keymap.set("x", lhs, function() return M.operator(style, "range") end,
            { expr = true, desc = desc })
    end

    map("<leader>cs", "snake", "To snake_case")
    map("<leader>cm", "camel", "To camelCase")
    map("<leader>cp", "pascal", "To PascalCase")
    map("<leader>ck", "kebab", "To kebab-case")
    map("<leader>cg", "screaming", "To SCREAMING_SNAKE")
end

return M
