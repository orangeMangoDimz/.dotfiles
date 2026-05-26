require "nvchad.options"

local o = vim.o
o.number = true
o.relativenumber = true
o.wrap = false
o.colorcolumn = "120"
o.scrolloff = 10
vim.opt.foldlevelstart = 99
o.autoread = true
-- winbar is set per-window via autocmd in autocmds.lua
