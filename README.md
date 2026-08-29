# Dotfiles

These files are managed with GNU Stow. The active desktop set is intentionally
limited to user configuration; browser profiles, caches, credentials, history,
and runtime databases stay outside the repository.

## Restore

```sh
git clone git@github.com:orangeMangoDimz/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive
stow -d ~/.dotfiles -t "$HOME" --restow \
  .tmux .tmux.conf \
  btop cava cursor fastfetch gtk-3.0 gtk-4.0 hypr \
  kitty Kvantum lazygit nwg-look nvim qt5ct qt6ct rofi \
  oh-my-zsh starship swappy swaync wallust waybar wlogout \
  xsettingsd zed zshrc
```

Install the system dependencies listed in `packages.arch.txt` first. Review
machine-specific monitor, wallpaper, and hardware settings before starting
Hyprland.

Install the Zsh plugins used by `.zshrc` into the restored Oh My Zsh tree:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/jeffreytse/zsh-vi-mode \
  ~/.oh-my-zsh/custom/plugins/zsh-vi-mode
```

`hyprland/` is a legacy overlapping package; use `hypr/` for the active setup.
The `chrome/` package is installed manually into the active Zen profile because
that profile path is machine-specific.
