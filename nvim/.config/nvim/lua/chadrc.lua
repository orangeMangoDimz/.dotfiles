-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

local headers = {
    {
        "                                             ",
        " ⠀⠀⣰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣴⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀ ",
        " ⠀⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⠀⠀⠀⠀⠀⢰⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧ ",
        " ⢀⡟⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸ ",
        " ⣸⠂⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⣿⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸ ",
        " ⣿⠀⠀⠀⠀⠀⢹⡿⣿⣿⣿⣿⡿⣿⡏⠀⣠⣿⣿⣿⣿⣿⣟⡛⠻⠿⠿⠿⢛⣛⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⣿⠀⠀⠀⠀⠀⢸⣿⣶⣦⣶⣶⣿⡿⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠ ",
        " ⢻⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣣⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢧⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸ ",
        " ⢸⡆⠀⠀⠀⠀⢰⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎ ",
        " ⠈⣇⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣳⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠁ ",
        " ⠀⢹⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠃⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⠿⠿⠿⠿⠿⠻⠛⠟⠛⠛⠛⠛⠛⠛⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠆⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀.⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠀⠀⠀.⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠀⢠⣾⣶⣤⣤⠀⡀⡠⢀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣵⣶⣾⣶⣿⣾⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⢨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣏⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⣼⣏⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀ ",
        "                                             ",
    },

    {
        "                                            ",
        " ⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠠⠤⠐⠒⠒⢢⡗⠒⠒⠒⠒⠶⠤⠄⣀⡀⠀⠀⠀⠀⠀⠻⡄⠀ ",
        " ⠀⠀⢠⡞⠀⠀⠀⠀⠀⠀⠀⠀⠤⠀⠀⠉⠀⠀⠀⠀⠀⠀⢠⣿⡇⠀⠀⠀⠀⠀⠀⠀⣇⠉⠙⠲⢦⣄⡀⠀⢹⡄ ",
        " ⠀⢀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣟⣿⣿⠀⠀⠀⠀⠀⠀⠀⣿⣆⠀⠀⠀⠈⠉⠷⣤⣷ ",
        " ⠀⣸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⢸⣿⣿⣄⠀⠀⠀⠀⠀⠈⢻ ",
        " ⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡿⠿⠿⠿⢿⣿⣿⡇⠀⠀⠀⠀⢀⣾⣿⣷⣾⣄⠀⠀⠀⠀⠀⠀ ",
        " ⢸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⡏⠀⠀⠀⠀⠰⣝⣿⡇⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀ ",
        " ⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣧⣾⡇⢀⣦⢠⣿⣿⠃⠀⠀⢠⣾⣿⡟⠛⠛⠻⣿⣿⣷⠀⠀⠀⠀ ",
        " ⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣭⣿⣟⣾⣿⠏⠀⠀⣰⣿⣿⣿⡇⠀⠀⠀⢠⣻⡿⠀⠀⠀⠀ ",
        " ⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⠘⣿⣿⣿⣿⣿⣿⣿⠋⠀⣠⣾⣿⣿⣿⣿⣷⣶⣠⣆⢸⣿⠃⠀⠀⠀⠀ ",
        " ⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣦⡹⣿⣿⣿⣿⡿⣃⣴⣿⣿⣿⣿⣿⣿⣿⣿⣽⣟⣯⣿⡟⠀⠀⠀⠀⢸ ",
        " ⠀⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⢀⠇ ",
        " ⠀⠠⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⡜⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣽⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠰⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⣠⣤⣄⠀⠀⠘⣶⣶⣶⣶⣾⣿⣿⣭⣿⣻⡿⠟⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠈⠀⠀⠾⠷⠿⢿⣿⣷⣦⣀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣄⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣭⣍⣉⡉⠛⠛⠻⠿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⣿⣿⡿⣿⣻⣿⣿⣿⣿⣿⣿⣟⣛⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀ ",
        " ⠀⠀⠀⠀⠀⠀⠋⢡⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⢿⣛⣯⣶⢾⣯⢭⡿⡟⠻⠿⢿⣿⠁⠀⠀⠀⠀⠀⠀⠀ ",
        "                                            ",
    },
}

local random_header = function()
    math.randomseed(os.time())
    local i = math.random(#headers)
    return headers[i]
end

M.base46 = {
    transparency = false,
}

M.nvdash = {
    load_on_startup = true,
    header = random_header(),
    buttons = {
        {
            txt = "🎄  Find File",
            keys = "Spc f f",
            cmd = "Telescope find_files",
        },
    },
}

M.term = {
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
        relative = "editor",
        row = 0.3,
        col = 0.25,
        width = 0.5,
        height = 0.4,
        border = "single",
    },
}

M.colorify = {
    enabled = true,
    mode = "fg", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
}

return M
