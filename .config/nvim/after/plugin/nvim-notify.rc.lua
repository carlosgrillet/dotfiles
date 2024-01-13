local status, notify = pcall(require, "notify")
if (not status) then return end

notify.setup({
  max_width = 80,
  fps = 60,
  stages = "fade",
  timeout = 500,
  render = "wrapped-compact",
})
