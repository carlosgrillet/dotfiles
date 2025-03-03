local status, copilot = pcall(require, "copilot")
if not status then
	vim.notify("Failed to load copilot")
	return
end

copilot.setup({
  panel = { enabled = false, },
  suggestion = { auto_trigger = true, },
})
