return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- dont show the winbar for some filetypes
    opts.options.disabled_filetypes.winbar = {
      "checkhealth",
      "dashboard",
      "snacks_terminal",
      "sidekick_terminal",
      "snacks_dashboard",
      "lazy",
      "alpha",
    }
    -- remove navic from the statusline
    local navic = table.remove(opts.sections.lualine_c)

    -- add it to the winbar instead
    opts.winbar = {
      lualine_c = {
        {
          "filename",
          -- color = { bg = "#222436" },
          cond = function()
            return vim.bo.buftype == ""
          end,
        },
        navic,
      },
    }
    opts.inactive_winbar = {
      lualine_c = {
        {
          "filename",
          -- color = { bg = "#222436" },
          cond = function()
            return vim.bo.buftype == ""
          end,
        },
      },
    }

    -- remove the clock
    opts.sections.lualine_z = {}
  end,
}
