local status, notify = pcall(require, "notify")
if (not status) then return end

notify.setup({
  render = "compact",
  fps = 60,
  stages = "fade",
  max_width = 80,
  timeout = 500,
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})
