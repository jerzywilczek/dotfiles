# dotfiles

hello welcome to my dotfiles

## Requirements

```sh
paru -S neovim-nightly-bin carapace-bin stow cmake ttf-jetbrains-mono-nerd git-delta fzf hyprland mako xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland waybar pavucontrol wlogout hyprpaper hyprlock hypridle brightnessctl hyprshot blueman rofi-wayland network-manager-applet qt6ct rofi-calc poweralertd ghostty niri kanshi
cargo install zoxide starship nu
```

## Usage

```sh
git clone git@github.com:jerzywilczek/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --dotfiles .
```

Then you need to go through `.template` files, fill them and remove the .template suffix.

## Fixups
- this might be neeed: `sudo ln -s /etc/xdg/menus/plasma-applications.menu /etc/xdg/menus/applications.menu`

## Todo

- [ ] waybar
  - [ ] brightness
- [ ] clipboard manager
