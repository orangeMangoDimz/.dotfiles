vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.copilot_no_tab_map = true
vim.g.have_nerd_font = true
vim.opt.termguicolors = true

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        repo,
        "--branch=stable",
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)
vim.opt.clipboard = "unnamedplus"

local lazy_config = require "configs.lazy"

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

vim.opt.conceallevel = 2
vim.o.ignorecase = true
vim.easymotion = true
-- Don't redraw the screen while running macros or scripts
vim.opt.lazyredraw = true

-- Don't bother with a swap file
vim.opt.swapfile = false
vim.opt.backup = false

-- Time in ms to wait for a mapped sequence to complete
vim.opt.timeoutlen = 300

-- Time in ms to wait for CursorHold event (used by many plugins)
-- A higher value can reduce CPU usage.
vim.opt.updatetime = 500


if vim.g.vscode then
    require("lazy").setup({
        {
            "NvChad/NvChad",
            lazy = false,
            branch = "v2.5",
            import = "nvchad.plugins",
        },

    }, lazy_config)

    -- Custom keybindings for VSCode
    -- vim.keymap.set('n', '<leader>ff', function()
    --     vim.fn.VSCodeNotify('workbench.action.quickOpen')
    -- end, { desc = 'Quick Open' })
    --
    -- vim.keymap.set('n', '<leader>fw', function()
    --     vim.fn.VSCodeNotify('workbench.action.findInFiles')
    -- end, { desc = 'Find Files' })
else
    require("lazy").setup({
        {
            "NvChad/NvChad",
            lazy = false,
            branch = "v2.5",
            import = "nvchad.plugins",
        },

        { import = "plugins" },
    }, lazy_config)

    -- load colorscheme
    vim.cmd.colorscheme "catppuccin"

    -- additional snippets
    require("luasnip").filetype_extend("vue", { "html", "css", "typescript" })
    require("luasnip").filetype_extend(
        "htmldjango",
        { "html", "css", "javascript" }
    )

    require "options"
    require "nvchad.autocmds"

    vim.schedule(function()
        require "mappings"
    end)
end
