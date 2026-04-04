require "nvchad.autocmds"

local file_icon = vim.fn.nr2char(0xf15b)
local folder_icon = vim.fn.nr2char(0xf07c)
local winbar_value = "%=" .. file_icon .. " %t  " .. folder_icon .. " %f%="

local excluded_filetypes = { "NvimTree", "terminal", "toggleterm", "alpha", "help", "qf", "TelescopePrompt" }
local excluded_buftypes = { "terminal", "nofile", "prompt" }

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "FileType" }, {
  callback = function()
    local bt = vim.bo.buftype
    local ft = vim.bo.filetype

    if vim.tbl_contains(excluded_buftypes, bt) or vim.tbl_contains(excluded_filetypes, ft) then
      vim.wo.winbar = nil
    else
      vim.wo.winbar = winbar_value
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
