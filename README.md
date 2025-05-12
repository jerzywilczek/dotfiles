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

## Todo

- [ ] add to readme:
  - installed: hyprland wofi mako xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland waybar pavucontrol wlogout hyprpaper hyprlock hypridle brightnessctl hyprshot
  - template device-specific config and instructions
- [ ] waybar
  - [x] network
  - [ ] brightness?
  - [?] power states - test on a PC
- [x] screenshots hyprshot
- [ ] mako config (notifications daemon)
- [ ] clipboard manager
- [ ] rofi-like launcher
- [x] wallpaper
- [x] locking
- [?] monitor switching
- [ ] wlogout
- [ ] theme qt?

