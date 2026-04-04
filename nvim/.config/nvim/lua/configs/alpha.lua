local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"

dashboard.section.header.val = {
  [[   ____                            __  ___                      ]],
  [[  / __ \_________ _____  ____ __  /  |/  /___ _____  ____ _____ ]],
  [[ / / / / ___/ __ `/ __ \/ __ `/ / /|_/ / __ `/ __ \/ __ `/ __ \]],
  [[/ /_/ / /  / /_/ / / / / /_/ / / /  / / /_/ / / / / /_/ / /_/ /]],
  [[\____/_/   \__,_/_/ /_/\__, / /_/  /_/\__,_/_/ /_/\__, /\____/ ]],
  [[                      /____/                      /____/        ]],
}

dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
  dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
  dashboard.button("w", "  Find word", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("n", "  New file", "<cmd>ene<CR>"),
  dashboard.button("t", "  File tree", "<cmd>NvimTreeToggle<CR>"),
  dashboard.button("s", "  Settings", "<cmd>e $MYVIMRC<CR>"),
  dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
}

dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

dashboard.section.footer.val = "OrangeMango"

dashboard.opts.layout = {
  { type = "padding", val = 4 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 2 },
  dashboard.section.footer,
}

alpha.setup(dashboard.opts)
