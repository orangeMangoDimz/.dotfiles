return {
    {
		-- override nvim-tree 
        "nvim-tree/nvim-tree.lua",
        opts = {
            git = {
                enable = true,
                ignore = false,
            },
            filters = {
                dotfiles = false,
                git_clean = false,
                no_buffer = false,
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        git = true,
                    },
                },
            },
            view = {
                width = 30,
                side = "right",
            },
        },
    },
    {
        -- hop
        "phaazon/hop.nvim",
        event = "VeryLazy",
        branch = "v2",
        config = function()
            require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
        end,
    },
    {
        -- todo comments
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = function()
            require "plugins.custom.todo-comments"
        end,
    },
    {
        -- git blame
        "f-person/git-blame.nvim",
        event = "VeryLazy",
        opts = {
            enabled = true,
            message_template = " <summary> • <date> • <author> • <<sha>>",
            date_format = "%m-%d-%Y %H:%M:%S",
            virtual_text_column = 1,
        },
    },
    {
        -- transparent
        "xiyaowong/transparent.nvim",
        event = "VimEnter",
        config = function()
            require "plugins.custom.transparant"
        end,
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
