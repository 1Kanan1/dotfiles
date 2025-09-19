local conditions = require("heirline.conditions")
local env = require("components.heirline.env")

return {
  opts = {
    colors = env.setup_colors,
    disable_winbar_cb = function(args)
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
        filetype = { "terminal", "^git.*", "fugitive", "Trouble", "snacks_dashboard" },
      }, args.buf)
    end,
  },

  statusline = require("components.heirline.statusline").StatusLine,
  winbar = require("components.heirline.winbar").WinBar,
  tabline = require("components.heirline.tabline").TabLine,
  -- statuscolumn = {},
}
