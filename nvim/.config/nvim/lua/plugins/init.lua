return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },

  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      widget_guides = { enabled = false },
      closing_tags = { enabled = true },
      lsp = {
        color = { enabled = false },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "dart" },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
        width = 30,
      },
      git = {
        enable = true,
        ignore = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      modified = {
        enable = true,
      },
      filters = {
        custom = { ".git", "node_modules", ".DS_Store", "__pycache__" },
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = { enable = true },
        },
      },
      renderer = {
        highlight_git = "name",
        highlight_modified = "name",
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = "after",
        },
      },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        api.config.mappings.default_on_attach(bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
        vim.keymap.set("n", "l", api.node.open.edit, opts)
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts)
      end,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          nvimtree = true,
          gitsigns = true,
          treesitter = true,
          nvim_web_devicons = true,
        },
        custom_highlights = function(colors)
          return {
            NvimTreeGitNew = { fg = colors.green },
            NvimTreeGitNewIcon = { fg = colors.green },
            NvimTreeGitDirty = { fg = colors.peach },
            NvimTreeGitDirtyIcon = { fg = colors.peach },
          }
        end,
      }
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },
    lazy = false,
    config = function()
      local project_icon = vim.fn.nr2char(0xf07c)
      local branch_icon = vim.fn.nr2char(0xe725)
      require("lualine").setup {
        options = {
          theme = "catppuccin-mocha",
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              function()
                return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
              end,
              icon = project_icon,
            },
            { "branch", icon = branch_icon },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      require "configs.alpha"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.mapping["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
          vim.schedule(function()
            cmp.abort()
          end)
        else
          fallback()
        end
      end)
    end,
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        split_side = "left",
        split_width_percentage = 0.30,
      },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)

      vim.api.nvim_create_autocmd("WinResized", {
        callback = function()
          local ok, terminal = pcall(require, "claudecode.terminal")
          if not ok then return end
          local bufnr = terminal.get_active_terminal_bufnr()
          if not bufnr then return end
          local winid = vim.fn.bufwinid(bufnr)
          if winid ~= -1 then
            vim.g._claude_saved_width = vim.api.nvim_win_get_width(winid)
          end
        end,
      })
    end,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      {
        "<leader>ac",
        function()
          local terminal = require("claudecode.terminal")
          local bufnr = terminal.get_active_terminal_bufnr()
          if bufnr then
            local winid = vim.fn.bufwinid(bufnr)
            if winid ~= -1 then
              vim.g._claude_saved_width = vim.api.nvim_win_get_width(winid)
            end
          end
          -- Update snacks terminal opts before toggle so it opens at saved width
          local saved = vim.g._claude_saved_width
          if saved then
            local instance = terminal._get_managed_terminal_for_test()
            if instance and instance.opts then
              instance.opts.width = saved
            end
          end
          vim.cmd("ClaudeCode")
        end,
        desc = "Toggle Claude",
      },
      {
        "<leader>af",
        function()
          local terminal = require("claudecode.terminal")
          local bufnr = terminal.get_active_terminal_bufnr()
          if bufnr then
            local winid = vim.fn.bufwinid(bufnr)
            if winid ~= -1 then
              vim.g._claude_saved_width = vim.api.nvim_win_get_width(winid)
            end
          end
          local saved = vim.g._claude_saved_width
          if saved then
            local instance = terminal._get_managed_terminal_for_test()
            if instance and instance.opts then
              instance.opts.width = saved
            end
          end
          vim.cmd("ClaudeCodeFocus")
        end,
        desc = "Focus Claude",
      },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  {
    "vyfor/cord.nvim",
    lazy = false,
    opts = {},
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {},
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = function(_, path)
          local tail = vim.fn.fnamemodify(path, ":t")
          local parent = vim.fn.fnamemodify(path, ":h")
          if parent == "." then
            return tail
          end

          local icon_width = 3
          local indent = 0

          -- Find Telescope results window width
          local win_width
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_is_valid(win) then
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "TelescopeResults" then
                win_width = vim.api.nvim_win_get_width(win)
                break
              end
            end
          end

          if not win_width then
            local display = tail .. "  " .. parent
            local hl = { { { #tail + 2, #display }, "TelescopeResultsComment" } }
            return display, hl
          end

          -- Fill first line, then path on next visual line with indent
          local fill = math.max(win_width - icon_width - #tail, 1)
          local padded = tail .. string.rep(" ", fill + indent) .. parent
          local path_pos = #tail + fill + indent
          local hl = { { { path_pos, #padded }, "TelescopeResultsComment" } }
          return padded, hl
        end,
        initial_mode = "normal",
        wrap_results = true,
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
        virt_text_pos = "eol",
      },
      current_line_blame_formatter = "  <author>, <author_time:%R> - <summary>",
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
