return {
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        config = function()
            require("image").setup {
                backend = "kitty",
                processor = "magick_rock", -- or "magick_cli"
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        floating_windows = false,              -- if true, images will be rendered in floating markdown windows
                        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        filetypes = { "norg" },
                    },
                    typst = {
                        enabled = true,
                        filetypes = { "typst" },
                    },
                    html = {
                        enabled = false,
                    },
                    css = {
                        enabled = false,
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = {
                    "cmp_menu",
                    "cmp_docs",
                    "snacks_notif",
                    "scrollview",
                    "scrollview_sign",
                },
                editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = {
                    "*.png",
                    "*.jpg",
                    "*.jpeg",
                    "*.gif",
                    "*.webp",
                    "*.avif",
                }, -- render image files as images when opened
            }
        end,
    },
    {
        -- obsidian
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        event = {
            "BufReadPre /home/mango/Documents/notes/obsidian-notes/*.md",
            "BufNewFile /home/mango/Documents/notes/obsidian-notes/*.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "/home/mango/Documents/notes/obsidian-notes",
                },
                -- {
                --     name = "work",
                --     path = "~/vaults/work",
                -- },
            },
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d-%a",
                time_format = "%H:%M",
            },
            attachments = {
                img_folder = "Images",
            },
        },
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = "gemini",
            providers = {
                gemini = {
                    endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
                    model = "gemini-2.5-pro-exp-03-25",
                    timeout = 30000, -- Timeout in milliseconds
                    temperature = 0,
                    max_tokens = 8192,
                },
            },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick",         -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua",              -- for file_selector provider fzf
            "stevearc/dressing.nvim",        -- for input provider dressing
            "folke/snacks.nvim",             -- for input provider snacks
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua",        -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
    -- Install without configuration
    { "projekt0n/github-nvim-theme", name = "github-theme" },
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
        'MeanderingProgrammer/render-markdown.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        opts = {},
        config = function()
            require("render-markdown").setup({
                heading = { border = true },
                indent = { enabled = true, skip_level = 0 },
                bullet = {
                    enabled = true,
                    render_modes = false,
                    icons = { '●', '○', '◆', '◇' },
                    ordered_icons = function(ctx)
                        local value = vim.trim(ctx.value)
                        local index = tonumber(value:sub(1, #value - 1))
                        return string.format('%d.', index > 1 and index or ctx.index)
                    end,
                    left_pad = 0,
                    right_pad = 0,
                    highlight = 'RenderMarkdownBullet',
                    scope_highlight = {},
                },
            })
        end,

    },

    -- {
    --     event = "VeryLazy",
    --     "MeanderingProgrammer/render-markdown.nvim",
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "echasnovski/mini.nvim",
    --     },
    --     config = function()
    --         require("render-markdown").setup {
    --             checkbox = {
    --                 -- Turn on / off checkbox state rendering
    --                 enabled = true,
    --                 -- Determines how icons fill the available space:
    --                 --  inline:  underlying text is concealed resulting in a left aligned icon
    --                 --  overlay: result is left padded with spaces to hide any additional text
    --                 position = "inline",
    --                 unchecked = {
    --                     -- Replaces '[ ]' of 'task_list_marker_unchecked'
    --                     icon = "󰄱 ",
    --                     -- Highlight for the unchecked icon
    --                     highlight = "RenderMarkdownUnchecked",
    --                     -- Highlight for item associated with unchecked checkbox
    --                     scope_highlight = nil,
    --                 },
    --                 checked = {
    --                     -- Replaces '[x]' of 'task_list_marker_checked'
    --                     icon = "󰱒 ",
    --                     -- Highlight for the checked icon
    --                     highlight = "RenderMarkdownChecked",
    --                     -- Highlight for item associated with checked checkbox
    --                     scope_highlight = nil,
    --                 },
    --                 -- Define custom checkbox states, more involved as they are not part of the markdown grammar
    --                 -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
    --                 -- Can specify as many additional states as you like following the 'todo' pattern below
    --                 --   The key in this case 'todo' is for healthcheck and to allow users to change its values
    --                 --   'raw':             Matched against the raw text of a 'shortcut_link'
    --                 --   'rendered':        Replaces the 'raw' value when rendering
    --                 --   'highlight':       Highlight for the 'rendered' icon
    --                 --   'scope_highlight': Highlight for item associated with custom checkbox
    --                 custom = {
    --                     todo = {
    --                         raw = "[-]",
    --                         rendered = "󰥔 ",
    --                         highlight = "RenderMarkdownTodo",
    --                         scope_highlight = nil,
    --                     },
    --                 },
    --             },
    --             indent = {
    --                 enabled = true,
    --                 per_level = 2,
    --                 skip_level = 1,
    --                 skip_heading = true,
    --             },
    --             bullet = {
    --                 enabled = true,
    --                 icons = { "●", "○", "◆", "◇" },
    --                 ordered_icons = {},
    --                 left_pad = 0,
    --                 right_pad = 1,
    --                 highlight = "RenderMarkdownBullet",
    --             },
    --         }
    --     end,
    --     ---@module 'render-markdown'
    --     ---@type render.md.UserConfig
    --     opts = {},
    -- },
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
    -- {
    -- git dashboard
    --     "nvimdev/dashboard-nvim",
    --     event = "VimEnter",
    --     dependencies = {
    --         {
    --             "juansalvatore/git-dashboard-nvim",
    --             dependencies = { "nvim-lua/plenary.nvim" },
    --         },
    --     },
    --     opts = function()
    --         local ascii_heatmap = require("git-dashboard-nvim").setup {
    --             days = { "s", "m", "t", "w", "t", "f", "s" },
    --             colors = {
    --                 --catpuccin theme
    --                 days_and_months_labels = "#8FBCBB",
    --                 empty_square_highlight = "#3B4252",
    --                 filled_square_highlights = {
    --                     "#88C0D0",
    --                     "#88C0D0",
    --                     "#88C0D0",
    --                     "#88C0D0",
    --                     "#88C0D0",
    --                     "#88C0D0",
    --                     "#88C0D0",
    --                 },
    --                 branch_highlight = "#88C0D0",
    --                 dashboard_title = "#88C0D0",
    --             },
    --             top_padding = 5,
    --             bottom_padding = 1,
    --         }
    --         local opts = {
    --             theme = "doom",
    --             config = {
    --                 header = ascii_heatmap,
    --                 center = {
    --                     {
    --                         action = "ene | startinsert",
    --                         desc = " New File",
    --                         icon = " ",
    --                         key = "n",
    --                     },
    --                     {
    --                         action = "Telescope oldfiles",
    --                         desc = " Recent Files",
    --                         icon = " ",
    --                         key = "r",
    --                     },
    --                     {
    --                         action = "Telescope live_grep",
    --                         desc = " Find Text",
    --                         icon = " ",
    --                         key = "g",
    --                     },
    --                     {
    --                         action = "Lazy",
    --                         desc = " Lazy",
    --                         icon = "󰒲 ",
    --                         key = "l",
    --                     },
    --                     {
    --                         action = "qa",
    --                         desc = " Quit",
    --                         icon = " ",
    --                         key = "q",
    --                     },
    --                 },
    --                 footer = function()
    --                     return {}
    --                 end,
    --             },
    --         }
    --         return opts
    --     end,
    -- },
    {
        -- Formatting
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require "null-ls"
            local formatting = null_ls.builtins.formatting
            null_ls.setup {
                -- sources = {
                --     formatting.prettier.with {
                --         filetypes = {
                --             "vue",
                --             "javascript",
                --             "typescript",
                --             "javascriptreact",
                --             "typescriptreact",
                --             "clangd",
                --             "lua",
                --             "css",
                --             "scss",
                --             "html",
                --             "json",
                --             "yaml",
                --             "markdown",
                --             "yaml",
                --         },
                --         extra_args = { "--tab-width", "4" },
                --     },
                --     formatting.clang_format,
                --     -- NOTE: to set the indent format of clangd, you need to create the .clang-format file int he project root
                --     --
                --     -- contians:
                --     -- BasedOnStyle: Google
                --     -- IndentWidth: 4
                --     -- TabWidth: 4
                --     -- UseTab: Never
                --     -- ColumnLimit: 100
                -- },
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
    --         local startify = require "alpha.themes.startify"
    --         startify.file_icons.provider = "mini"
    --         require("alpha").setup(startify.config)
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
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            auto_install = true,

            -- The main module to enable.
            highlight = {
                enable = true, -- REQUIRED. Enables syntax highlighting.
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some flicker.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            -- highlight = { enable = true },
            -- sync_install = false,
            -- indent = { enable = true },
        },
    },
}
