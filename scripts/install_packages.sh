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
    "wlogout"
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
)

# Check yay is installed
echo ":: Checking yay is installed"
_installYay

# Install required packages
echo ":: Installing system packages..."
_installPackages "${PACMAN_PACKAGES[@]}"

echo ":: Installing AUR packages..."
_installPackagesYay "${YAY_PACKAGES[@]}"

echo ":: Package installation complete!"

