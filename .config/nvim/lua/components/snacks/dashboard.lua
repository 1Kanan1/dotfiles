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
    {
      pane = 2,
      icon = " ",
      desc = "Browse Repo",
      padding = 1,
      key = "b",
      action = function()
        Snacks.gitbrowse()
      end,
    },
    -- TODO: update the function to support both github and gitlab (gh & glab)
    function()
      local in_git = Snacks.git.get_root() ~= nil
      local cmds = {}

      local function gh_has_remote(callback)
        vim.fn.jobstart({ "gh", "repo", "view" }, {
          stdout_buffered = true,
          on_exit = function(_, code)
            callback(code == 0)
          end,
        })
      end

      table.insert(cmds, {
        title = "Notifications",
        cmd = "gh notify -s -a -n5",
        action = function()
          vim.ui.open("https://github.com/notifications")
        end,
        key = "N",
        icon = " ",
        height = 5,
        enabled = true,
      })

      gh_has_remote(function(has_remote)
        if has_remote then
          table.insert(cmds, {
            title = "Open Issues",
            cmd = "gh issue list -L 3",
            key = "i",
            action = function()
              vim.fn.jobstart("gh issue list --web", { detach = true })
            end,
            icon = " ",
            height = 7,
          })
          table.insert(cmds, {
            icon = " ",
            title = "Open PRs",
            cmd = "gh pr list -L 3",
            key = "P",
            action = function()
              vim.fn.jobstart("gh pr list --web", { detach = true })
            end,
            height = 7,
          })
        end
      end)

      table.insert(cmds, {
        icon = " ",
        title = "Git Status",
        cmd = "git --no-pager diff --stat -B -M -C",
        height = 10,
      })

      return vim.tbl_map(function(cmd)
        return vim.tbl_extend("force", {
          pane = 2,
          section = "terminal",
          enabled = in_git,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        }, cmd)
      end, cmds)
    end,
    { section = "startup" },
  },
}

return M
