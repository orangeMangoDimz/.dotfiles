-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

	hl_override = {
		Comment = { fg = "#bac2de", italic = true },
		["@comment"] = { fg = "#bac2de", italic = true },
	},
}

M.ui = {
  tabufline = {
    enabled = false,
  },
}

return M
