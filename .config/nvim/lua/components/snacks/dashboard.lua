local M = {}

M.opts = {
  preset = {
    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  },
  sections = {
    { section = "header" },
    { pane = 1, icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
    { pane = 1, icon = " ", title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = 1 },
    { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
    { section = "startup" },
  },
}

return M
