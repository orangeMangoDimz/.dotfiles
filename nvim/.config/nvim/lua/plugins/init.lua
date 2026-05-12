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
      flutter_path = vim.fn.expand("$HOME/snap/flutter/common/flutter/bin/flutter"),
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
        width = function() return math.floor(vim.o.columns * 0.20) end,
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
        custom = { "^\\.git$", "node_modules", ".DS_Store", "__pycache__" },
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
      local colors = require("catppuccin.palettes").get_palette("mocha")

      local mode_colors = {
        n  = colors.mauve,
        i  = colors.green,
        v  = colors.flamingo,
        V  = colors.flamingo,
        ["\22"] = colors.flamingo,
        c  = colors.peach,
        R  = colors.red,
        t  = colors.teal,
      }

      local mode_labels = {
        n  = "NORMAL",
        i  = "INSERT",
        v  = "VISUAL",
        V  = "V-LINE",
        ["\22"] = "V-BLOCK",
        c  = "COMMAND",
        R  = "REPLACE",
        t  = "TERMINAL",
      }

      require("lualine").setup {
        options = {
          theme = "catppuccin-mocha",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              function()
                return mode_labels[vim.fn.mode()] or vim.fn.mode()
              end,
              color = function()
                return { fg = colors.base, bg = mode_colors[vim.fn.mode()] or colors.blue, gui = "bold" }
              end,
            },
          },
          lualine_b = {
            { "branch", icon = "" },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              diff_color = {
                added    = { fg = colors.green },
                modified = { fg = colors.peach },
                removed  = { fg = colors.red },
              },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = { modified = "  ", readonly = "  ", unnamed = "  " },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
              diagnostics_color = {
                error = { fg = colors.red },
                warn  = { fg = colors.peach },
                info  = { fg = colors.sky },
                hint  = { fg = colors.teal },
              },
            },
            { "filetype" },
          },
          lualine_y = { "location" },
          lualine_z = { "progress" },
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
        split_width_percentage = 0.40,
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
          vim.cmd("ClaudeCode --dangerously-skip-permissions")
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
    "johnseth97/codex.nvim",
    lazy = false,
    cmd = { "Codex", "CodexToggle" },
    init = function()
      local CODEX_PANEL_WIDTH = 0.40
      local group = vim.api.nvim_create_augroup("CodexPanelLeft", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
        group = group,
        callback = function(args)
          if vim.bo[args.buf].filetype ~= "codex" then
            return
          end

          local win = vim.fn.bufwinid(args.buf)
          if win == -1 or not vim.api.nvim_win_is_valid(win) then
            return
          end

          if not vim.g._codex_saved_width then
            vim.g._codex_saved_width = math.floor(vim.o.columns * CODEX_PANEL_WIDTH)
          end

          vim.api.nvim_win_call(win, function()
            vim.cmd "wincmd H"
          end)

          pcall(vim.api.nvim_win_set_width, win, vim.g._codex_saved_width)
        end,
      })

      vim.api.nvim_create_autocmd({ "WinResized", "WinLeave", "BufWinLeave" }, {
        group = group,
        callback = function(args)
          local win = tonumber(args.match)
          if not win or win == 0 or not vim.api.nvim_win_is_valid(win) then
            return
          end

          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype ~= "codex" then
            return
          end

          vim.g._codex_saved_width = vim.api.nvim_win_get_width(win)
        end,
      })
    end,
    opts = {
      panel = true,
      width = 0.40,
      cmd = { "codex", "--yolo" },
      use_buffer = false,
      keymaps = {
        toggle = nil,
        quit = "<C-q>",
      },
    },
    keys = {
      {
        "<leader>ax",
        function()
          require("codex").toggle()
        end,
        mode = { "n", "t" },
        desc = "Toggle Codex",
      },
      {
        "<leader>aS",
        function()
          local startPos = vim.fn.getpos("'<")
          local endPos = vim.fn.getpos("'>")
          if startPos[2] == 0 or endPos[2] == 0 then
            vim.notify("No visual selection found", vim.log.levels.WARN)
            return
          end

          local selectionType = vim.fn.visualmode()
          if selectionType == "" then
            selectionType = "v"
          end

          local region = vim.fn.getregion(startPos, endPos, { type = selectionType })
          local selectedText = table.concat(region, "\n")

          if selectedText == "" then
            vim.notify("Empty visual selection", vim.log.levels.WARN)
            return
          end
          selectedText = selectedText:gsub("\n+$", "")

          local codex = require("codex")
          local state = require("codex.state")
          local wasHidden = not (state.win and vim.api.nvim_win_is_valid(state.win))

          if wasHidden then
            codex.open()
          end

          local payload = "```txt\n" .. selectedText .. "\n```"
          local sendSelection = function()
            local activeState = require("codex.state")
            if not activeState.job then
              vim.notify("Codex job not running", vim.log.levels.ERROR)
              return
            end

            vim.fn.chansend(activeState.job, payload)
            vim.fn.chansend(activeState.job, "\r")
            vim.notify("Selection sent to Codex", vim.log.levels.INFO)
          end

          local attempt = 0
          local MAX_ATTEMPTS = 20
          local RETRY_DELAY_MS = 80

          local function trySend()
            attempt = attempt + 1
            local activeState = require("codex.state")
            if activeState.job then
              sendSelection()
              return
            end

            if attempt >= MAX_ATTEMPTS then
              vim.notify("Codex job not ready after waiting", vim.log.levels.ERROR)
              return
            end

            vim.defer_fn(trySend, RETRY_DELAY_MS)
          end

          trySend()
        end,
        mode = "x",
        desc = "Send selection to Codex",
      },
    },
  },

  {
    "vyfor/cord.nvim",
    enabled = false,
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
