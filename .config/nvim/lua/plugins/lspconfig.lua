return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        copilot = false,
        pyright = false,
      },
      inlay_hints = {
        enabled = false,
        exclude = { "http" },
      },
    },
  },
}
