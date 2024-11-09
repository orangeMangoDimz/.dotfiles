return {
    {
        -- lorem ipsum
        "derektata/lorem.nvim",
        event = "VeryLazy",
        config = function()
            require("lorem").opts {
                sentenceLength = "medium",
                comma_chance = 0.2,
                max_commas_per_sentence = 2,
            }
        end,
    },
    {
        "mbbill/undotree",
        event = "VimEnter",
    },
    {
        -- git dashboard
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = {
            {
                "juansalvatore/git-dashboard-nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        opts = function()
            local ascii_heatmap = require("git-dashboard-nvim").setup {
                days = { "s", "m", "t", "w", "t", "f", "s" },
                colors = {
                    --catpuccin theme
                    days_and_months_labels = "#8FBCBB",
                    empty_square_highlight = "#3B4252",
                    filled_square_highlights = {
                        "#88C0D0",
                        "#88C0D0",
                        "#88C0D0",
                        "#88C0D0",
                        "#88C0D0",
                        "#88C0D0",
                        "#88C0D0",
                    },
                    branch_highlight = "#88C0D0",
                    dashboard_title = "#88C0D0",
                },
                top_padding = 5,
                bottom_padding = 1,
            }
            local opts = {
                theme = "doom",
                config = {
                    header = ascii_heatmap,
                    center = {
                        {
                            action = "ene | startinsert",
                            desc = " New File",
                            icon = " ",
                            key = "n",
                        },
                        {
                            action = "Telescope oldfiles",
                            desc = " Recent Files",
                            icon = " ",
                            key = "r",
                        },
                        {
                            action = "Telescope live_grep",
                            desc = " Find Text",
                            icon = " ",
                            key = "g",
                        },
                        {
                            action = "Lazy",
                            desc = " Lazy",
                            icon = "󰒲 ",
                            key = "l",
                        },
                        {
                            action = "qa",
                            desc = " Quit",
                            icon = " ",
                            key = "q",
                        },
                    },
                    footer = function()
                        return {}
                    end,
                },
            }

            -- extra dashboard nvim config ...

            return opts
        end,
    },
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
        "IogaMaster/neocord",
        event = "VeryLazy",
        config = function()
            -- The setup config table shows all available config options with their default values:
            require("neocord").setup {
                -- General options
                logo = "auto", -- "auto" or url
                logo_tooltip = nil, -- nil or string
                main_image = "language", -- "language" or "logo"
                client_id = "1157438221865717891", -- Use your own Discord application client id (not recommended)
                log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
                debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
                blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
                file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
                show_time = true, -- Show the timer
                global_timer = false, -- if set true, timer won't update when any event are triggered

                -- Rich Presence text options
                editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
                file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
                git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
                plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
                reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
                workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
                line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
                terminal_text = "Using Terminal", -- Format string rendered when in terminal mode.
            }
        end,
    },
    -- {
    --     -- discord
    --     "andweeb/presence.nvim",
    --     event = "VimEnter",
    --     config = function()
    --         require("presence").setup {
    --             auto_update = true,
    --             neovim_image_text = "The One True Text Editor",
    --             main_image = "neovim",
    --             client_id = "793271441293967371",
    --             log_level = "debug",
    --             debounce_timeout = 10,
    --             enable_line_number = false,
    --             blacklist = {},
    --             buttons = true,
    --             file_assets = {},
    --             show_time = true,
    --             editing_text = "Editing %s",
    --             file_explorer_text = "Browsing %s",
    --             git_commit_text = "Committing changes",
    --             plugin_manager_text = "Managing plugins",
    --             reading_text = "Reading %s",
    --             workspace_text = "Working on %s",
    --             line_number_text = "Line %s out of %s",
    --         }
    --     end,
    -- },
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
    -- {
    --     -- alpha dashboard
    --     "goolord/alpha-nvim",
    --     event = "VimEnter",
    --     config = function()
    --         require("alpha").setup(require("alpha.themes.dashboard").config)
    --     end,
    -- },
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
                "python",
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
