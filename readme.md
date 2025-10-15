# Screenshot

![Discrod](./screenshot/discord.png)

![btop](./screenshot/btop.png)

![browser](./screenshot/browser.png)

![kitty](./screenshot/kitty-terminal.png)

![neofetch](./screenshot/netofetch-and-notification.png)

![nvim-and-music](./screenshot/nvim-and-music.png)

![nvim](./screenshot/nvim.png)

> NOTE

To run app in the wayland feature, just use the following flags:
```bash
<app_name> --ozone-platform=x11 --enable-features=WaylandWindowDecorations
```

To fix obs and discord screen share, you need to add [xdg-desktop-portal-hyprland](https://github.com/hyprwm/xdg-desktop-portal-hyprland). Follow the instruction with some dependencies installed to build it from source. Then, add this to hyprland config
```bash
exec-once=dbus-update-activation-environment --systemd WAYLAND
```
Source: [Screen sharing on Hyprland (Arch Linux)](https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580)

To fix the `libpipewire-0.3-0` version issue (required >= 1.1.82)
You can run this command:
```bash
# Install build dependencies
sudo apt build-dep pipewire

# Download and build
wget https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/1.1.82/pipewire-1.1.82.tar.gz
tar -xf pipewire-1.1.82.tar.gz
cd pipewire-1.1.82
meson setup build --prefix=/usr
ninja -C build
sudo ninja -C build install
```
After installing, you can use `sudo apt update -y && sudo apt upgrade libpipewire-0.3-0 -y` command to update the version 