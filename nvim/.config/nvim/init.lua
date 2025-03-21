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

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
    require "mappings"
end)

-- load colorscheme
vim.cmd.colorscheme "catppuccin"
-- vim.cmd.colorscheme "github_dark_default"
-- vim.cmd.colorscheme "tokyodark"

vim.opt.conceallevel = 2
-- additional snippets
require("luasnip").filetype_extend("vue", { "html", "css", "typescript" })
require("luasnip").filetype_extend(
    "htmldjango",
    { "html", "css", "javascript" }
)
