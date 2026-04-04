require "nvchad.options"

local o = vim.o
o.relativenumber = true
o.wrap = false
o.colorcolumn = "120"
o.scrolloff = 10
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
o.autoread = true
-- winbar is set per-window via autocmd in autocmds.lua
