local prefix = "config.userfunctions."
local dir = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "config", "userfunctions")

local names = {}
for name, kind in vim.fs.dir(dir) do
    if kind == "file" and name:match("%.lua$") and name ~= "init.lua" then
        names[#names + 1] = name:sub(1, -5)
    end
end
table.sort(names)

for _, name in ipairs(names) do
    local ok, mod = pcall(require, prefix .. name)
    if not ok then
        vim.notify(("userfunctions: failed to load '%s'\n%s"):format(name, mod), vim.log.levels.ERROR)
    elseif type(mod) == "table" and type(mod.setup) == "function" then
        local ok_setup, err = pcall(mod.setup)
        if not ok_setup then
            vim.notify(("userfunctions: '%s'.setup() failed\n%s"):format(name, err), vim.log.levels.ERROR)
        end
    end
end
