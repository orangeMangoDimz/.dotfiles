require "nvchad.options"

local o = vim.o
o.relativenumber = true
o.wrap = false
o.colorcolumn = "120"
o.scrolloff = 10
local file_icon = vim.fn.nr2char(0xf15b)
local folder_icon = vim.fn.nr2char(0xf07c)
vim.o.winbar = "%=" .. file_icon .. " %t  " .. folder_icon .. " %f%="
