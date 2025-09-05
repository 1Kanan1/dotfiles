return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        local luasnip = require("luasnip")

        -- Extend snippets for JSX/TSX and Django
        luasnip.filetype_extend("javascriptreact", { "html" })
        luasnip.filetype_extend("typescriptreact", { "html" })
        luasnip.filetype_extend("htmldjango", { "html" })

        -- Lazy-load snippets
        require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "all" } })
      end,
    },
    "nvim-tree/nvim-web-devicons",
    "onsails/lspkind.nvim",
  },

  opts = function()
    local lspkind = require("lspkind")

    -- Highlight groups
    local blend = 20
    local highlights = {
      { "BlinkCmpMenuSelection", { link = "PmenuSel" } },
      { "BlinkCmpMenu", { default = true, blend = blend, bg = "NONE" } },
      { "BlinkCmpMenuBorder", { default = true, blend = blend, bg = "NONE" } },
      { "BlinkCmpDoc", { default = true, link = "BlinkCmpMenu" } },
      { "BlinkCmpDocBorder", { default = true, link = "BlinkCmpMenuBorder" } },
    }
    for _, h in ipairs(highlights) do
      vim.api.nvim_set_hl(0, h[1], h[2])
    end

    -- Helper for border characters (used for menu)
    local function border(hl)
      return {
        { "╭", hl },
        { "─", hl },
        { "╮", hl },
        { "│", hl },
        { "╯", hl },
        { "─", hl },
        { "╰", hl },
        { "│", hl },
      }
    end

    return {
      keymap = { preset = "default" },
      snippets = { preset = "luasnip" },
      appearance = { nerd_font_variant = "normal" },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = {
          border = border("BlinkCmpMenuBorder"),
          winhighlight = "Normal:BlinkCmpMenu,CursorLine:BlinkCmpMenuSelection,Search:None",
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
                  end
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local _, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_hl then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
            },
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    }
  end,
  opts_extend = { "sources.default" },
}
