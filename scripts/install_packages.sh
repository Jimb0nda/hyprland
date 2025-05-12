#!/bin/bash
set -e

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
    "dotnet-runtime"
    "dotnet-sdk"
    "cmake"
    "dex"
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
    "hyprshot"
)

# Install required packages
info "Installing system packages..."
_installPackages "${PACMAN_PACKAGES[@]}"

# Check yay is installed
info "Checking yay is installed"
_installYay

info "Installing AUR packages..."
_installPackagesYay "${YAY_PACKAGES[@]}"

success "Package installation complete!"

rm -rf ~/.cache/QtProject || warn "Could not remove ~/.cache/QtProject"
rm -rf ~/.config/QtProject || warn "Could not remove ~/.config/QtProject"

