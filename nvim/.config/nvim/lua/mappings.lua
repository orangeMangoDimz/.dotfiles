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

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
