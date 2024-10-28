return {
    {
        -- Formatting
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require "null-ls"
            local formatting = null_ls.builtins.formatting
            null_ls.setup {
                sources = {
                    formatting.prettier.with {
                        filetypes = {
                            "javascript",
                            "typescript",
                            "vue",
                            "css",
                            "scss",
                            "html",
                            "json",
                            "yaml",
                            "markdown",
                        },
                        extra_args = { "--tab-width", "4" },
                    },
                },
            }
        end,
    },
    {
        -- discord
        "andweeb/presence.nvim",
        event = "VimEnter",
        config = function()
            require("presence").setup {
                auto_update = true,
                neovim_image_text = "The One True Text Editor",
                main_image = "neovim",
                client_id = "793271441293967371",
                log_level = nil,
                debounce_timeout = 10,
                enable_line_number = false,
                blacklist = {},
                buttons = true,
                file_assets = {},
                show_time = true,
                editing_text = "Editing %s",
                file_explorer_text = "Browsing %s",
                git_commit_text = "Committing changes",
                plugin_manager_text = "Managing plugins",
                reading_text = "Reading %s",
                workspace_text = "Working on %s",
                line_number_text = "Line %s out of %s",
            }
        end,
    },
    {
        -- live server
        "barrett-ruth/live-server.nvim",
        event = "VeryLazy",
        build = "pnpm add -g live-server",
        cmd = { "LiveServerStart", "LiveServerStop" },
        config = true,
    },
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
            message_template = " <author> • <summary> • <date> • <<sha>>",
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
        -- used for parser, ex syntax_highlight
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "typescript",
                "javascript",
                "vue",
                "html",
                "scss",
                "cssls",
                "css",
                "markdown",
                "markdown_inline",
                "json",
                "yaml",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
