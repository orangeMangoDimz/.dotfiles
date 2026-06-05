require "nvchad.options"

-- "tokyonight" | "catppuccin"
vim.g.active_theme = "tokyonight"

local o = vim.o
o.number = true
o.relativenumber = true
o.wrap = false
o.colorcolumn = "120"
o.scrolloff = 10
vim.opt.foldlevelstart = 99
o.autoread = true
-- winbar is set per-window via autocmd in autocmds.lua

-- Prevent OSC52 sequences from leaking into Claude Code (or any outer TUI) prompt.
-- nvim's osc52.lua probes terminal on UIEnter; disabling here skips the probe entirely.
vim.g.termfeatures = { osc52 = false }

-- Explicitly use wl-clipboard on Wayland so nvim never falls back to OSC52.
if vim.env.WAYLAND_DISPLAY then
  vim.g.clipboard = {
    name = 'wl-clipboard',
    copy  = { ['+'] = { 'wl-copy' }, ['*'] = { 'wl-copy', '--primary' } },
    paste = { ['+'] = { 'wl-paste', '--no-newline' }, ['*'] = { 'wl-paste', '--no-newline', '--primary' } },
    cache_enabled = 0,
  }
end
