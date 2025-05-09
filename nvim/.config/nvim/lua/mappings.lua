require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Accept completion copilot
map("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
})

-- LSP Rename
map(
    "n",
    "<leader>rn",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    { noremap = true, silent = true, desc = "Rename symbol" }
)

-- Undo tree config
map("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "View Undo Tree" })

-- Harpoon keybinding configuration
local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

-- Keybindings for marking and navigating files
map("n", "<leader>ta", mark.add_file, { desc = "Add file to Harpoon" })
map(
    "n",
    "<leader>te",
    ui.toggle_quick_menu,
    { desc = "Toggle Harpoon quick menu" }
)

-- Quick navigation to harpoon marks
for i = 1, 5 do
    map("n", "<leader>" .. i, function()
        ui.nav_file(i)
    end, { desc = "Navigate to harpoon mark " .. i })
end

-- Additional navigation commands
map("n", "<leader>tp", ui.nav_prev, { desc = "Navigate to previous mark" })
map("n", "<leader>tn", ui.nav_next, { desc = "Navigate to next mark" })

-- Optional: Clear all marks (useful for cleanup)
map(
    "n",
    "<leader>tc",
    require("harpoon.mark").clear_all,
    { desc = "Clear all harpoon marks" }
)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the selected line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move the selected line up" })
-- map("x", "<leader>p", '"_dP', { desc = "Paste without copying" })

-- DBUI
map('n', '<Leader>db', ':DBUIToggle<CR>', { desc = "Toogle DB UI", noremap = true, silent = true })
map('n', '<Leader>cb', '<cmd>%bd|e#<CR>', { desc = "Clear All Buffers", noremap = true, silent = true })

-- Obsidian Keybindings
map("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create a new note" })
map("n", "<leader>os", "<cmd>ObsidianTags<CR>", { desc = "Show tags" })
map("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename note" })
map({"n", "v"}, "<leader>oln", "<cmd>ObsidianLinkNew<CR>", { desc = "Create a new link" })
map("n", "<leader>olv", "<cmd>ObsidianLinks<CR>", { desc = "Show current buffer links" })
map("n", "<leader>oti", "<cmd>ObsidianTemplate<CR>", { desc = "Insert template" })
map("n", "<leader>otn",  "<cmd>ObsidianNewFromTemplate<CR>", { desc = "Create a new note from template" })
map("n", "<leader>oc", "<cmd>ObsidianTOC<CR>", { desc = "Show table of contents" })

-- formatting
-- map("n", "<leader>fm", function()
--   require("conform").format({ async = true, lsp_fallback = true })
-- end, { desc = "custom format files" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
