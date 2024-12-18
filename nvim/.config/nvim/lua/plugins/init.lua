return {
    {
        -- tokyodark theme
        "tiagovla/tokyodark.nvim",
        config = function(_, opts)
            require("tokyodark").setup(opts)
        end,
    },
    {
        -- dadbod db ui
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { "sql", "mysql", "plsql" },
                lazy = true,
            },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            -- for completion
            local cmp = require "cmp"
            cmp.setup.filetype({ "sql" }, {
                sources = {
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" },
                },
            })
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    {
        -- completion db helper
        "saghen/blink.cmp",
        opts = {
            sources = {
                completion = {
                    enabled_providers = {
                        "lsp",
                        "path",
                        "snippets",
                        "buffer",
                        "dadbod",
                    },
                },
                providers = {
                    dadbod = {
                        name = "Dadbod",
                        module = "vim_dadbod_completion.blink",
                    },
                },
            },
        },
    },
    {
        -- obsidian
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        event = {
            "BufReadPre /home/dimz/Documents/notes/obsidian-notes/*.md",
            "BufNewFile /home/dimz/Documents/notes/obsidian-notes/*.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "/home/dimz/Documents/notes/obsidian-notes",
                },
                -- {
                --     name = "work",
                --     path = "~/vaults/work",
                -- },
            },
        },
    },
    -- {
    --     -- Noice notification
    --     "folke/noice.nvim",
    --     event = "VimEnter",
    --     config = function()
    --         require("noice").setup {
    --             lsp = {
    --                 override = {
    --                     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                     ["vim.lsp.util.stylize_markdown"] = true,
    --                     ["cmp.entry.get_documentation"] = true,
    --                 },
    --             },
    --             presets = {
    --                 bottom_search = true,
    --                 command_palette = true,
    --                 long_message_to_split = true,
    --                 inc_rename = false,
    --                 lsp_doc_border = false,
    --             },
    --         }
    --     end,
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     },
    -- },
    {
        "ThePrimeagen/harpoon",
    },
    {
        -- markdown preview
        -- NOTE: need to install manually at ~/.local/share/nvim/lazy/markdown-preview.nvim
        -- use the `npm i` at that location
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        -- render markdown
        event = "VeryLazy",
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.nvim",
        },
        config = function()
            require("render-markdown").setup {
                checkbox = {
                    -- Turn on / off checkbox state rendering
                    enabled = true,
                    -- Determines how icons fill the available space:
                    --  inline:  underlying text is concealed resulting in a left aligned icon
                    --  overlay: result is left padded with spaces to hide any additional text
                    position = "inline",
                    unchecked = {
                        -- Replaces '[ ]' of 'task_list_marker_unchecked'
                        icon = "󰄱 ",
                        -- Highlight for the unchecked icon
                        highlight = "RenderMarkdownUnchecked",
                        -- Highlight for item associated with unchecked checkbox
                        scope_highlight = nil,
                    },
                    checked = {
                        -- Replaces '[x]' of 'task_list_marker_checked'
                        icon = "󰱒 ",
                        -- Highlight for the checked icon
                        highlight = "RenderMarkdownChecked",
                        -- Highlight for item associated with checked checkbox
                        scope_highlight = nil,
                    },
                    -- Define custom checkbox states, more involved as they are not part of the markdown grammar
                    -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
                    -- Can specify as many additional states as you like following the 'todo' pattern below
                    --   The key in this case 'todo' is for healthcheck and to allow users to change its values
                    --   'raw':             Matched against the raw text of a 'shortcut_link'
                    --   'rendered':        Replaces the 'raw' value when rendering
                    --   'highlight':       Highlight for the 'rendered' icon
                    --   'scope_highlight': Highlight for item associated with custom checkbox
                    custom = {
                        todo = {
                            raw = "[-]",
                            rendered = "󰥔 ",
                            highlight = "RenderMarkdownTodo",
                            scope_highlight = nil,
                        },
                    },
                },
                indent = {
                    enabled = true,
                    per_level = 2,
                    skip_level = 1,
                    skip_heading = false,
                },
                bullet = {
                    enabled = true,
                    icons = { "●", "○", "◆", "◇" },
                    ordered_icons = {},
                    left_pad = 0,
                    right_pad = 1,
                    highlight = "RenderMarkdownBullet",
                },
            }
        end,
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
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
                            "vue",
                            "javascript",
                            "typescript",
                            "javascriptreact",
                            "typescriptreact",
                            "clangd",
                            "lua",
                            "css",
                            "scss",
                            "html",
                            "json",
                            "yaml",
                            "markdown",
                        },
                        extra_args = { "--tab-width", "4" },
                    },
                    formatting.clang_format,
                    -- NOTE: to set the indent format of clangd, you need to create the .clang-format file int he project root
                    --
                    -- contians:
                    -- BasedOnStyle: Google
                    -- IndentWidth: 4
                    -- TabWidth: 4
                    -- UseTab: Never
                    -- ColumnLimit: 100
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
        config = function()
            require("catppuccin").setup {
                flavour = "mocha", -- latte, frappe, macchiato, mocha
            }
        end,
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
    -- {
    --     -- auto-save
    --     "pocco81/auto-save.nvim",
    --     event = { "InsertLeave", "TextChanged" },
    --     config = function()
    --         require "plugins.custom.auto-save"
    --     end,
    -- },
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
