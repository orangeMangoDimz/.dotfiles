require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- Remove conflicting NvChad defaults
-- <leader>h (was: new horizontal terminal -- still available via <A-h>)
-- <leader>v (was: new vertical terminal -- still available via <A-v>)
-- <leader>b (was: new buffer -- need prefix free for harpoon)
-- <leader>e (was: NvimTreeFocus -- replaced by <leader>ee)
del("n", "<leader>h")
del("n", "<leader>v")
del("n", "<leader>b")
del("n", "<leader>e")

-- ========================================
-- Existing custom mappings
-- ========================================
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ========================================
-- Splits
-- ========================================
map("n", "<leader>h", "<cmd>vsplit<CR>", { desc = "Split right (vertical split)" })
map("n", "<leader>v", "<cmd>split<CR>", { desc = "Split down (horizontal split)" })

-- ========================================
-- NvimTree
-- ========================================
map("n", "<leader>ee", "<cmd>NvimTreeFocus<CR>", { desc = "NvimTree focus" })
map("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree toggle" })

-- ========================================
-- LSP
-- ========================================
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP references" })

-- ========================================
-- Navigation
-- ========================================
map("n", "gb", "<C-o>", { desc = "Go back (jumplist)" })

-- ========================================
-- Editor management
-- ========================================
map("n", "<leader>db", "<cmd>bufdo bd<CR>", { desc = "Close all buffers" })
map("n", "<leader>ww", "<cmd>set wrap!<CR>", { desc = "Toggle word wrap" })

-- ========================================
-- Window resize
-- ========================================
map("n", "<A-S-l>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<A-S-h>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

-- ========================================
-- Git
-- ========================================
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- ========================================
-- Harpoon
-- ========================================
local harpoon = require "harpoon"
harpoon:setup()

map("n", "<leader>ba", function()
  harpoon:list():add()
end, { desc = "Harpoon add file" })

map("n", "<leader>be", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon edit list" })

map("n", "<leader>bl", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon list/pick" })

map("n", "<leader>1", function()
  harpoon:list():select(1)
end, { desc = "Harpoon file 1" })

map("n", "<leader>2", function()
  harpoon:list():select(2)
end, { desc = "Harpoon file 2" })

map("n", "<leader>3", function()
  harpoon:list():select(3)
end, { desc = "Harpoon file 3" })

map("n", "<leader>4", function()
  harpoon:list():select(4)
end, { desc = "Harpoon file 4" })

map("n", "<leader>5", function()
  harpoon:list():select(5)
end, { desc = "Harpoon file 5" })

map("n", "<leader>6", function()
  harpoon:list():select(6)
end, { desc = "Harpoon file 6" })
