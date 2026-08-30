local M = {}

local function get_colors()
  local c = require("base46").get_theme_tb("base_30")
  return {
    normal = c.purple, insert = c.green, visual = c.blue,
    command = c.orange, replace = c.red, terminal = c.teal,
    bg = c.black, blue = c.blue,
    file = c.white, path = c.light_grey, sep = c.grey, mod = c.orange,
  }
end

function M.get_colors()
  return get_colors()
end

function M.update_winbar()
  local c = get_colors()
  vim.api.nvim_set_hl(0, "WinBarFile", { fg = c.file, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "WinBarPath", { fg = c.path, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBarSep",  { fg = c.sep,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBarMod",  { fg = c.mod,  bg = "NONE" })
end

return M
