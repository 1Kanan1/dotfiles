return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  enabled = false,
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("sonarlint").setup({
      server = {
        cmd = {
          "sonarlint-language-server",
          "-stdio",
          "-analyzers",
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarts.jar"),
        },
        settings = {
          sonarlint = {
            connectedMode = {
              connections = {
                sonarqube = {
                  {
                    connectionId = "my-sonarqube",
                    serverUrl = "https://sonarqube9.andersenlab.com",
                    disableNotifications = false,
                  },
                },
              },
            },
          },
        },
      },
      connected = {
        get_credentials = function()
          return vim.fn.getenv("SONAR_TOKEN") -- use mise.toml to handle env
        end,
      },
      filetypes = {
        javascript = "sonarjs",
        typescript = "sonarts",
      },
    })
  end,
}
