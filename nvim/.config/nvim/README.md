# Neovim Config

NvChad v2.5 based config. Leader key: `Space`

## Custom Keybindings

### General

| Key | Mode | Description |
|-----|------|-------------|
| `;` | Normal | Enter command mode |
| `jk` | Insert | Escape |

### Splits

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>h` | Normal | Split right (vertical split) |
| `<leader>v` | Normal | Split down (horizontal split) |

### Pane Resizing

| Key | Mode | Description |
|-----|------|-------------|
| `<A-L>` | Normal | Increase pane width |
| `<A-H>` | Normal | Decrease pane width |
| `<A-J>` | Normal | Increase pane height |
| `<A-K>` | Normal | Decrease pane height |

### Terminal Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | Terminal | Switch to left window |
| `<C-j>` | Terminal | Switch to bottom window |
| `<C-k>` | Terminal | Switch to top window |
| `<C-l>` | Terminal | Switch to right window |

### Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `gb` | Normal | Go back (jumplist) |

### Editor Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>x` | Normal | Close buffer (prompts if unsaved) |
| `<leader>db` | Normal | Close all buffers |
| `<leader>ww` | Normal | Toggle word wrap |

### NvimTree

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ee` | Normal | Focus NvimTree |
| `<leader>et` | Normal | Toggle NvimTree |
| `l` | Normal (tree) | Open file |
| `h` | Normal (tree) | Navigate parent / close directory |

### LSP

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cr` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code action |
| `gr` | Normal | References (Telescope) |
| `<leader>ds` | Normal | Diagnostics (Telescope) |
| `<leader>dd` | Normal | Show diagnostic float |

### Git

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gg` | Normal | Open LazyGit |
| `<leader>gd` | Normal | Diff current file (side-by-side) |
| `<leader>gr` | Normal | Reset hunk |
| `<leader>gr` | Visual | Reset selected lines |
| `<leader>gb` | Normal | Toggle git blame |
| `<leader>gB` | Normal | Full git blame (popup) |
| `<leader>gn` | Normal | Next git diff file |
| `<leader>gp` | Normal | Previous git diff file |

### Flutter

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Fr` | Normal | Flutter run |
| `<leader>Fq` | Normal | Flutter quit |
| `<leader>FR` | Normal | Flutter restart |
| `<leader>Fl` | Normal | Flutter hot reload |
| `<leader>Fd` | Normal | Flutter devices |
| `<leader>Fe` | Normal | Flutter emulators |
| `<leader>Fo` | Normal | Flutter widget outline |
| `<leader>Ft` | Normal | Flutter DevTools |
| `<leader>Fg` | Normal | Flutter clear log |

### Harpoon

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ba` | Normal | Add file to Harpoon |
| `<leader>be` | Normal | Edit Harpoon list |
| `<leader>bl` | Normal | Show Harpoon list |
| `<leader>1` - `<leader>6` | Normal | Jump to Harpoon file 1-6 |

### Claude Code

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ac` | Normal | Toggle Claude Code |
| `<leader>af` | Normal | Focus Claude Code |
| `<leader>ar` | Normal | Resume Claude |
| `<leader>aC` | Normal | Continue Claude |
| `<leader>am` | Normal | Select Claude model |
| `<leader>ab` | Normal | Add current buffer |
| `<leader>as` | Visual | Send selection to Claude |
| `<leader>as` | Normal (tree) | Add file from file tree |
| `<leader>aa` | Normal | Accept diff |
| `<leader>ad` | Normal | Deny diff |

### Completion (nvim-cmp)

| Key | Mode | Description |
|-----|------|-------------|
| `<CR>` | Insert | Confirm completion |

## Credits

1. [NvChad](https://github.com/NvChad/NvChad) v2.5
2. [LazyVim starter](https://github.com/LazyVim/starter) - inspired NvChad's starter
