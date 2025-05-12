# dotfiles

hello welcome to my dotfiles

## Requirements

```sh
paru -S neovim-nightly-bin carapace-bin kitty stow cmake ttf-jetbrains-mono-nerd git-delta fzf
cargo install zoxide starship nu
```

## Usage

```sh
git clone git@github.com:jerzywilczek/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --dotfiles .
```

## Fixups
- this might be neeed: `sudo ln -s /etc/xdg/menus/plasma-applications.menu /etc/xdg/menus/applications.menu`

## Todo

- [ ] add to readme:
  - installed: hyprland mako xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland waybar pavucontrol wlogout hyprpaper hyprlock hypridle brightnessctl hyprshot blueman rofi-wayland network-manager-applet qt6ct
  - template device-specific config and instructions
- [ ] waybar
  - [x] network
  - [ ] brightness?
  - [x] power states - test on a PC
- [x] screenshots hyprshot
- [x] mako config (notifications daemon)
- [ ] clipboard manager
- [x] rofi-like launcher
- [x] wallpaper
- [x] locking
- [x] monitor switching
- [x] wlogout
- [x] theme qt?

