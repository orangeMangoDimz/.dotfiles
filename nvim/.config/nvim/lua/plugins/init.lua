return {
  {
    -- transparent
    "xiyaowong/transparent.nvim",
    event = "VimEnter",
    config = function ()
      require "plugins.custom.transparant"
    end
  },
  {
    -- catppuccin themes
    "catppuccin/nvim",
    event = "VimEnter",
    name = "catppuccin",
    priority = 1000,
  },
  {
    -- alpha dashboard
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  {
    -- copilot
    "github/copilot.vim",
    event = "VeryLazy",
  },
  {
    -- auto-save
    "pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    config = function()
      require "plugins.custom.auto-save"
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
}
