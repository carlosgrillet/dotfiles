local status, lualine = pcall(require, "lualine")
if not status then
	vim.notify("Failed to load lualine")
	return
end

local function macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register ~= "" then
        return "REC: @" .. recording_register
    else
        return ""
    end
end

lualine.setup({
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
})
