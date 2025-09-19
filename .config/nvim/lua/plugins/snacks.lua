return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
      -- to avoid unexpected behaviors, keep it in deps
      {
        "kevinhwang91/nvim-ufo",
        event = "BufReadPre",
        dependencies = {
          "kevinhwang91/promise-async",
        },
        config = function()
          vim.o.foldlevel = 99
          vim.o.foldlevelstart = 99

          require("ufo").setup({
            provider_selector = function()
              return { "treesitter", "indent" }
            end,
          })
        end,
      },
    },
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = require("components.snacks.dashboard").opts,
      explorer = { enabled = true },
      indent = {
        animate = {
          enabled = false,
        },
      },
      input = { enabled = true },
      image = { enabled = true },
      picker = {
        sources = {
          explorer = {
            layout = { layout = { position = "right" } },
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = require("components.snacks.statuscolumn").opts,
      words = { enabled = true },
    },
    -- stylua: ignore
    config = function(_, opts)
      local wk = require("which-key")
      local Snacks = require("snacks")
      Snacks.setup(opts)

      -- TODO: fix which-key and add icons
      wk.add({
        { "<leader>s", desc = "search" },
        { "<leader>g", desc = "git" },
        { "<leader>u", desc = "ui", icon = "" },

        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>,",  function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>/",  function() Snacks.picker.grep({ hidden = true }) end, desc = "Grep", icon = "" },
        { "<leader>:",  function() Snacks.picker.command_history() end, desc = "Command History", icon = "" },
        { "<leader>e",  function() Snacks.explorer({ cwd = vim.fs.root(0, ".git") }) end, desc = "File Explorer", icon = "" },

        -- lazy
        { "<leader>l", desc = "+lazy" },
        { "<leader>ll", "<cmd>Lazy<cr>", desc = "Lazy" },
        { "<leader>ld",
          function()
            Snacks.terminal.toggle("lazydocker", {
              interactive = true,
              win = { border = "rounded", title = "lazydocker" }
            })
          end,
          desc = "Lazydocker",
          icon = { icon = "", color = "blue" }
        },
        { "<leader>lp",
          function()
            Snacks.terminal.toggle("lazydocker", {
              interactive = true,
              env = {
                DOCKER_HOST = "unix:///var/folders/qm/cpldggtd3c9fm24dz_g7mjgc0000gn/T/podman/podman-machine-default-api.sock"
              },
              win = { border = "rounded", title = "lazypodman" }
            })
          end,
          desc = "Lazypodman",
          icon = ""
        },

        -- toggle
        { "<leader>t", desc = "Toggle" },
        { "<leader>tc", function() require("copilot.command").toggle() end, desc = "Toggle Copilot", icon = "" },

        -- notification
        { "<leader>n", desc = "noice/notifications", icon = { icon = "󰈸", color = "orange" } },
        { "<leader>ns", function() Snacks.picker.notifications() end, desc = "Show Notifications", icon = { icon = "󰈸", color = "orange" } },
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History", icon = "" },
        { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", icon = "󰎟" },

        -- buffer
        { "<leader>b", desc = "+buffer", icon = "" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers" },

        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fh", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files (Hidden)" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

        -- git
        { "<leader>gb", function() Snacks.picker.git_branches({ cwd = vim.fs.root(0, '.git'), all = true }) end, desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log({ cwd = vim.fs.root(0, '.git') }) end, desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status({ cwd = vim.fs.root(0, '.git') }) end, desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash({ cwd = vim.fs.root(0, '.git') }) end, desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff({ cwd = vim.fs.root(0, '.git') }) end, desc = "Git Diff (Hunks)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
        { "<leader>gB", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
        { "<leader>ge", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit({ cwd = vim.fs.root(0, '.git'), win = { border = "rounded", title = "lazygit" } }) end, desc = "Lazygit" },

        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep({ cwd = vim.fs.root(0, '.git'), hidden = true }) end, desc = "Grep" },
        { "<leader>sG", function() Snacks.picker.git_grep({ cwd = vim.fs.root(0, '.git'), hidden = true }) end, desc = "Grep (Git)" },
        { "<leader>sw", function() Snacks.picker.grep_word({ cwd = vim.fs.root(0, '.git'), hidden = true }) end, desc = "Visual selection or word", mode = { "n", "x" } },

        -- search
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>sr", function() Snacks.picker.recent() end, desc = "Recent" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },

        -- colorschemes
        { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes", icon = "" },

        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", icon = "󰙅" },
        { "gD",         function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration", icon = "󰙅" },
        { "gr",         function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation", icon = "󰙅" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition", icon = "󰙅" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

        -- Other
        { "<c-/>",      function() Snacks.terminal.toggle(nil, { cwd = vim.fn.getcwd() }) end, desc = "Toggle Terminal Window", mode = { 'n', 't' } },
        { "<c-_>",      function() Snacks.terminal.toggle(nil, { cwd = vim.fn.getcwd() }) end, desc = "which_key_ignore", mode = { 'n', 't' } },
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", icon = "󰑕" },
        -- { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    event = "BufReadPre",
    opts = {},
	   -- stylua: ignore
	   keys = {
	     { "<leader>st", function() Snacks.picker.todo_comments({ hidden = true }) end, desc = "Todo" },
	     { "<leader>sT", function () Snacks.picker.todo_comments({ hidden = true, keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
	   },
  },
}
