require "nvchad.autocmds"

local file_icon = vim.fn.nr2char(0xf15b)
local folder_icon = vim.fn.nr2char(0xf07c)

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

  local win_width = vim.api.nvim_win_get_width(0)

  -- Narrow window: only show filename
  if win_width < 60 then
    return file_icon .. " " .. filename
  end

  -- Get full path relative to git root, fallback to cwd-relative
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

  return file_icon .. " " .. filename .. "  " .. folder_icon .. " " .. rel_path
end

local excluded_filetypes = { "NvimTree", "terminal", "toggleterm", "alpha", "help", "qf", "TelescopePrompt" }
local excluded_buftypes = { "terminal", "nofile", "prompt" }

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "FileType" }, {
  callback = function()
    local bt = vim.bo.buftype
    local ft = vim.bo.filetype

    if vim.tbl_contains(excluded_buftypes, bt) or vim.tbl_contains(excluded_filetypes, ft) then
      vim.wo.winbar = nil
    else
      vim.wo.winbar = "%=%{v:lua.winbar_content()}%="
    end
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})




vim.api.nvim_create_user_command("LspFullRestart", function()
  vim.diagnostic.reset()
  vim.cmd("LspStop")
  vim.defer_fn(function()
    vim.cmd("LspStart")
    vim.cmd("bufdo e")
  end, 500)
end, {})
