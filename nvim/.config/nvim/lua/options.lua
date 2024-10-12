require "nvchad.options"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.wo.relativenumber = true
-- vim.opt.colorcolumn = "120"
vim.opt.scrolloff = 10

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


local tree = require("nvim-tree")
-- show the git ignore files
-- tree.opt.gitignore = true
