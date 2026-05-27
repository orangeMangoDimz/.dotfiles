-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

	hl_override = {
		Comment = { fg = "#7f849c", italic = true },
		["@comment"] = { fg = "#7f849c", italic = true },
	},
}

M.ui = {
  tabufline = {
    enabled = false,
  },
}

M.term = {
  sizes = { sp = 0.3, vsp = 0.3 },
}

return M
