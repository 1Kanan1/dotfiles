return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- dont show the winbar for some filetypes
    opts.options.disabled_filetypes.winbar =
      { "checkhealth", "dashboard", "snacks_terminal", "sidekick_terminal", "snacks_dashboard", "lazy", "alpha" }
    -- remove navic from the statusline
    local navic = table.remove(opts.sections.lualine_c)
    -- add it to the winbar instead
    opts.winbar = { lualine_b = { "filename" }, lualine_c = { navic } }

    -- add branch clickability
    opts.sections.lualine_b = {
      {
        "branch",
        on_click = function()
          Snacks.picker.git_branches()
        end,
      },
    }

    -- remove the clock
    opts.sections.lualine_z = {}
  end,
}
