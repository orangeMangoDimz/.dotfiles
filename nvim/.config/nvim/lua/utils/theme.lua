local M = {}


local TOKYONIGHT_OPTS = {
  style = "night",
  transparent = true,
  on_highlights = function(hl, c)
    hl["@markup.raw.markdown_inline"] = { fg = c.cyan, bold = true }
    hl["@text.literal"]               = { fg = c.cyan, bold = true }
  end,
}

local CATPPUCCIN_OPTS = {
  flavour = "mocha",
  transparent_background = true,
  integrations = {
    nvimtree = true,
    gitsigns = true,
    treesitter = true,
  },
}

function M.load_preference()
  local v = vim.g.active_theme
  if v == "catppuccin" or v == "tokyonight" then return v end
  return "tokyonight"
end

local function get_colors()
  local scheme = vim.g.colors_name or ""
  if scheme:find("tokyonight") then
    local c = require("tokyonight.colors").setup({ style = "night" })
    return {
      normal = c.magenta, insert = c.green, visual = c.blue,
      command = c.orange, replace = c.red, terminal = c.teal,
      bg = c.bg, blue = c.blue,
      file = c.fg, path = c.comment, sep = c.fg_gutter, mod = c.orange,
    }
  else
    local c = require("catppuccin.palettes").get_palette("mocha")
    return {
      normal = c.mauve, insert = c.green, visual = c.flamingo,
      command = c.peach, replace = c.red, terminal = c.teal,
      bg = c.base, blue = c.blue,
      file = c.text, path = c.overlay1, sep = c.surface2, mod = c.peach,
    }
  end
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

function M.apply(name)
  if name == "catppuccin" then
    require("catppuccin").setup(CATPPUCCIN_OPTS)
    pcall(vim.cmd.colorscheme, "catppuccin-mocha")
  else
    require("tokyonight").setup(TOKYONIGHT_OPTS)
    pcall(vim.cmd.colorscheme, "tokyonight-night")
  end
  vim.schedule(function()
    M.update_winbar()
    require("lualine").refresh()
  end)
end

function M.startup()
  M.apply(M.load_preference())
end


return M
