local status, noice = pcall(require, "noice")
if (not status) then return end

noice.setup({
  views = {
    cmdline_popup = {
      border = {
        style = "none",
        padding = { 1, 1 },
      },
      filter_options = {},
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
  },
})
