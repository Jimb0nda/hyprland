#!/bin/bash

# System packages to install via Pacman
PACMAN_PACKAGES=(
    "wget"
    "unzip"
    "gum"
    "rsync"
    "figlet"
    "git"
    "base-devel"
    "waybar"
    "hyprpaper"
    "hyprlock"
    "firefox"
    "vim"
    "pavucontrol"
    "bluez-utils"
    "blueman"
    "yazi"
    "ffmpegthumbnailer"
    "fd"
    "ripgrep"
    "fzf"
    "bat"
    "brightnessctl"
    "neovim"
    "tmux"
    "polkit-kde-agent"
    "noto-fonts-emoji"
    "python-requests"
    "networkmanager"
    "pipewire"
    "wireplumber"
    "pipewire-pulse"
    "pipewire-alsa"
    "fprint"
    "tar"
    "qt5-quickcontrols2"
    "qt5-base"
    "qt5-declarative"
    "qt5-graphicaleffects"
)

# AUR packages to install via Yay
YAY_PACKAGES=(
    "wlogout"
    "wev"
    "starship"
    "fastfetch"
    "wttrbar"
    "lazydocker"
    "lazygit"
    "steam"
)

# Install required packages
echo ":: Installing system packages..."
_installPackages "${PACMAN_PACKAGES[@]}"

# Check yay is installed
echo ":: Checking yay is installed"
#_installYay

echo ":: Installing AUR packages..."
#_installPackagesYay "${YAY_PACKAGES[@]}"

echo ":: Package installation complete!"

rm -rf ~/.cache/QtProject/
rm -rf ~/.config/QtProject/

