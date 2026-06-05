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
    init = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
      vim.g.lazygit_floating_window_winblend = 0
    end,
  },

  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      flutter_path = "/usr/bin/flutter",
      widget_guides = { enabled = false },
      closing_tags = { enabled = true },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "dart",
        "python",
        "javascript",
        "typescript",
        "jsx",
        "tsx",
        "php",
        "go",
        "html",
        "css",
        "json",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = math.floor(vim.o.columns * 0.4),
        float = {
          enable = true,
          quit_on_focus_loss = false,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            return {
              relative = "editor",
              border = "none",
              row = 0,
              col = 0,
              width = screen_w,
              height = screen_h,
            }
          end,
        },
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
          quit_on_open = true,
          resize_window = false,
          window_picker = { enable = false },
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
        local map_opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
        vim.keymap.set("n", "l", api.node.open.edit, map_opts)
        vim.keymap.set("n", "h", api.node.navigate.parent_close, map_opts)
      end,
    },
    config = function(_, opts)
      local preview = { win = nil, buf = nil }

      local function tree_width()
        return math.floor(vim.opt.columns:get() * 0.4)
      end

      local function ensure_buf()
        if preview.buf and vim.api.nvim_buf_is_valid(preview.buf) then
          return preview.buf
        end
        preview.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[preview.buf].bufhidden = "wipe"
        vim.bo[preview.buf].buflisted = false
        return preview.buf
      end

      local function go_to_tree()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NvimTree" then
            vim.api.nvim_set_current_win(win)
            return
          end
        end
      end

      local function ensure_win()
        if preview.win and vim.api.nvim_win_is_valid(preview.win) then
          return preview.win
        end
        local buf = ensure_buf()
        local sw = vim.opt.columns:get()
        local sh = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local tw = tree_width()
        preview.win = vim.api.nvim_open_win(buf, false, {
          relative = "editor",
          border = "none",
          row = 0,
          col = tw,
          width = sw - tw,
          height = sh,
          style = "minimal",
          zindex = 51,
          focusable = true,
        })
        vim.wo[preview.win].number = true
        vim.wo[preview.win].wrap = false
        vim.keymap.set("n", "<C-h>", go_to_tree, { buffer = buf, noremap = true, silent = true })
        return preview.win
      end

      local function close_preview()
        if preview.win and vim.api.nvim_win_is_valid(preview.win) then
          vim.api.nvim_win_close(preview.win, true)
        end
        preview.win = nil
      end

      local function update_preview()
        local api = require "nvim-tree.api"
        local ok, node = pcall(api.tree.get_node_under_cursor)
        if not ok or not node then return end

        local buf = ensure_buf()
        ensure_win()

        if node.type ~= "file" then
          vim.bo[buf].modifiable = true
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
          vim.bo[buf].modifiable = false
          vim.bo[buf].filetype = ""
          return
        end

        local path = node.absolute_path
        local uv = vim.uv or vim.loop
        local stat = uv.fs_stat(path)
        if not stat or stat.size > 1024 * 1024 then
          vim.bo[buf].modifiable = true
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "[binary or large file]" })
          vim.bo[buf].modifiable = false
          vim.bo[buf].filetype = ""
          return
        end

        local read_ok, lines = pcall(vim.fn.readfile, path)
        if not read_ok then return end

        vim.bo[buf].modifiable = true
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].modifiable = false

        if preview.win and vim.api.nvim_win_is_valid(preview.win) then
          vim.api.nvim_win_set_cursor(preview.win, { 1, 0 })
        end

        local ft = vim.filetype.match({ filename = path, buf = buf }) or ""
        vim.bo[buf].filetype = ft
      end

      local orig_attach = opts.on_attach
      opts.on_attach = function(bufnr)
        if orig_attach then orig_attach(bufnr) end
        vim.keymap.set("n", "<C-l>", function()
          local win = ensure_win()
          if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_current_win(win)
          end
        end, { buffer = bufnr, noremap = true, silent = true, nowait = true })
      end

      require("nvim-tree").setup(opts)

      local augroup = vim.api.nvim_create_augroup("NvimTreePreview", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "NvimTree",
        callback = function(ev)
          ensure_win()
          update_preview()
          vim.api.nvim_create_autocmd("CursorMoved", {
            group = augroup,
            buffer = ev.buf,
            callback = update_preview,
          })
          vim.api.nvim_create_autocmd({ "BufHidden", "BufUnload" }, {
            group = augroup,
            buffer = ev.buf,
            once = true,
            callback = close_preview,
          })
        end,
      })
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          size = { width = 60, height = "auto" },
        },
        popupmenu = {
          relative = "editor",
          position = { row = "50%", col = "50%" },
          size = { width = 60, height = 10 },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { "catppuccin" },
    config = function()
      require("utils.theme").startup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim", "catppuccin" },
    lazy = false,
    config = function()
      local mode_labels = {
        n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE",
        ["\22"] = "V-BLOCK", c = "COMMAND", R = "REPLACE", t = "TERMINAL",
      }
      local mc_keys = { n = "normal", i = "insert", v = "visual", V = "visual", ["\22"] = "visual", c = "command", R = "replace", t = "terminal" }

      require("lualine").setup {
        options = {
          theme = "auto",
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
                local c = require("utils.theme").get_colors()
                return { fg = c.bg, bg = c[mc_keys[vim.fn.mode()]] or c.blue, gui = "bold" }
              end,
            },
          },
          lualine_b = {
            { "branch", icon = "" },
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
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

          vim.schedule(function()
            if not vim.api.nvim_win_is_valid(win) then
              return
            end
            vim.api.nvim_win_call(win, function()
              vim.cmd "wincmd H"
              vim.wo.winfixwidth = true
            end)
            pcall(vim.api.nvim_win_set_width, win, vim.g._codex_saved_width)
          end)
        end,
      })

      vim.api.nvim_create_autocmd("WinResized", {
        group = group,
        callback = function()
          for _, win in ipairs(vim.v.event.windows or {}) do
            if vim.api.nvim_win_is_valid(win) then
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "codex" then
                vim.g._codex_saved_width = vim.api.nvim_win_get_width(win)
                break
              end
            end
          end
        end,
      })

      vim.api.nvim_create_autocmd("WinClosed", {
        group = group,
        callback = function(args)
          local win = tonumber(args.match)
          if not win or not vim.api.nvim_win_is_valid(win) then
            return
          end
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "codex" then
            vim.g._codex_saved_width = vim.api.nvim_win_get_width(win)
          end
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
        mode = "n",
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
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.99,
          height = 0.99,
          preview_cutoff = 0,
        },
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
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      animate = { enabled = true },
      scroll = { enabled = true },
      indent = { enabled = true },
      words = { enabled = true },
      dim = { enabled = true },
      zen = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      bigfile = { enabled = true },
    },
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {},
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Downloads", "/" },
      session_options = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions",
    },
    keys = {
      { "<leader>ss", "<cmd>AutoSession search<cr>", desc = "Search sessions" },
      { "<leader>sd", "<cmd>AutoSession delete<cr>", desc = "Delete session" },
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
