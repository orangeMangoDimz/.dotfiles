require "nvchad.autocmds"

-- Winbar highlight groups using catppuccin palette
local function setup_winbar_highlights()
  local ok, palette = pcall(require, "catppuccin.palettes")
  if not ok then return end
  local c = palette.get_palette("mocha")
  vim.api.nvim_set_hl(0, "WinBarFile", { fg = c.text,     bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "WinBarPath", { fg = c.overlay1, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBarSep",  { fg = c.surface2, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBarMod",  { fg = c.peach,    bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_winbar_highlights })
setup_winbar_highlights()

local function get_git_root(bufnr)
  if vim.b[bufnr].winbar_git_root ~= nil then
    return vim.b[bufnr].winbar_git_root
  end

  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == "" then
    vim.b[bufnr].winbar_git_root = false
    return false
  end

  local dir = vim.fn.fnamemodify(filepath, ":h")
  local result = vim.fn.systemlist("git -C " .. vim.fn.shellescape(dir) .. " rev-parse --show-toplevel 2>/dev/null")
  if vim.v.shell_error == 0 and #result > 0 then
    vim.b[bufnr].winbar_git_root = result[1]
    return result[1]
  end

  vim.b[bufnr].winbar_git_root = false
  return false
end

function _G.winbar_content()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:match("^gitsigns://") then return "" end
  local filename = vim.fn.expand("%:t")
  if filename == "" then return "" end

  -- Filetype icon with color from nvim-web-devicons
  local icon, icon_hl = "󰈙", "WinBarFile"
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    local ic, hl = devicons.get_icon(filename, vim.fn.expand("%:e"), { default = true })
    if ic then icon, icon_hl = ic, (hl or "WinBarFile") end
  end

  local modified = vim.bo.modified and " %#WinBarMod#●" or ""

  local win_width = vim.api.nvim_win_get_width(0)
  if win_width < 60 then
    return "%=" .. "%#" .. icon_hl .. "#" .. icon .. " %#WinBarFile#" .. filename .. modified .. "%="
  end

  -- Relative path from git root or cwd
  local bufnr = vim.api.nvim_get_current_buf()
  local git_root = get_git_root(bufnr)
  local rel_path

  if git_root then
    local filepath = vim.fn.expand("%:p")
    if filepath:sub(1, #git_root) == git_root then
      rel_path = filepath:sub(#git_root + 2)
    else
      rel_path = vim.fn.expand("%:.")
    end
  else
    rel_path = vim.fn.expand("%:.")
  end

  -- Breadcrumb: dimmed path parts  bright filename
  local dir = vim.fn.fnamemodify(rel_path, ":h")
  local crumbs = ""
  if dir ~= "." then
    local parts = vim.split(dir, "/")
    local segments = {}
    for _, part in ipairs(parts) do
      segments[#segments + 1] = "%#WinBarPath#" .. part
    end
    crumbs = table.concat(segments, " %#WinBarSep# ") .. " %#WinBarSep# "
  end

  return "%=" .. crumbs .. "%#" .. icon_hl .. "#" .. icon .. " %#WinBarFile#" .. filename .. modified .. "%="
end

local excluded_filetypes = { "NvimTree", "terminal", "toggleterm", "alpha", "help", "qf", "TelescopePrompt" }
local excluded_buftypes  = { "terminal", "nofile", "prompt" }

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "FileType" }, {
  callback = function()
    local bt = vim.bo.buftype
    local ft = vim.bo.filetype
    if vim.tbl_contains(excluded_buftypes, bt) or vim.tbl_contains(excluded_filetypes, ft) then
      vim.wo.winbar = nil
    else
      vim.wo.winbar = "%{%v:lua.winbar_content()%}"
    end
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})

vim.api.nvim_create_autocmd("WinResized", {
  callback = function()
    for _, winid in ipairs(vim.v.event.windows) do
      local ok, buf = pcall(vim.api.nvim_win_get_buf, winid)
      if ok and vim.bo[buf].filetype == "NvimTree" then
        vim.g._nvimtree_saved_width = vim.api.nvim_win_get_width(winid)
      end
    end
  end,
})

vim.api.nvim_create_user_command("LspFullRestart", function()
  vim.diagnostic.reset()
  vim.cmd("LspStop")
  vim.defer_fn(function()
    vim.cmd("LspStart")
    vim.cmd("bufdo e")
  end, 500)
end, {})
