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
del("n", "<leader>e")
pcall(del, "n", "<leader>b")

-- ========================================
-- Existing custom mappings
-- ========================================
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ========================================
-- Terminal window navigation
-- ========================================
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Switch to left window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Switch to bottom window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Switch to top window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Switch to right window" })

-- ========================================
-- Pane resizing
-- ========================================
map("n", "<A-L>", "<cmd>vertical resize +2<CR>", { desc = "Increase pane width" })
map("n", "<A-H>", "<cmd>vertical resize -2<CR>", { desc = "Decrease pane width" })
map("n", "<A-J>", "<cmd>resize +2<CR>", { desc = "Increase pane height" })
map("n", "<A-K>", "<cmd>resize -2<CR>", { desc = "Decrease pane height" })

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
map("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })
map("n", "<leader>db", "<cmd>bufdo bd<CR>", { desc = "Close all buffers" })
map("n", "<leader>ww", "<cmd>set wrap!<CR>", { desc = "Toggle word wrap" })



-- ========================================
-- Git
-- ========================================
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff current file (side-by-side)" })

-- ========================================
-- Flutter
-- ========================================
map("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { desc = "Flutter run" })
map("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter quit" })
map("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "Flutter restart" })
map("n", "<leader>Fl", "<cmd>FlutterReload<CR>", { desc = "Flutter hot reload" })
map("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { desc = "Flutter devices" })
map("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter emulators" })
map("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter widget outline" })
map("n", "<leader>Ft", "<cmd>FlutterDevTools<CR>", { desc = "Flutter DevTools" })
map("n", "<leader>Fg", "<cmd>FlutterLogClear<CR>", { desc = "Flutter clear log" })

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
