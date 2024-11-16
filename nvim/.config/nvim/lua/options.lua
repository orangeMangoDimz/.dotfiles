require "nvchad.options"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.wo.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
-- vim.opt.colorcolumn = "120"
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.colorcolumn = "120"
vim.opt.updatetime = 50
vim.opt.guicursor = ""

local hop = require "hop"
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
    hop.hint_char1 {
        direction = directions.AFTER_CURSOR,
        current_line_only = true,
    }
end, { remap = true })
vim.keymap.set("", "F", function()
    hop.hint_char1 {
        direction = directions.BEFORE_CURSOR,
        current_line_only = true,
    }
end, { remap = true })
vim.keymap.set("", "t", function()
    hop.hint_char1 {
        direction = directions.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1,
    }
end, { remap = true })
vim.keymap.set("", "T", function()
    hop.hint_char1 {
        direction = directions.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1,
    }
end, { remap = true })

function toggle_wrap()
    vim.wo.wrap = not vim.wo.wrap
    -- Optional: also toggle line break settings
    if vim.wo.wrap then
        vim.wo.linebreak = true
        vim.wo.breakindent = true
    else
        vim.wo.linebreak = false
        vim.wo.breakindent = false
    end
end

vim.keymap.set("n", "<leader>ww", toggle_wrap, { desc = "Toggle word wrap" })
