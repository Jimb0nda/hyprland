#!/bin/bash

# ----------------------------------------------------- 
# Functions for Setup
# ----------------------------------------------------- 

distro="arch"
installer="arch"

# ----------------------------------------------------- 
# Packages
# ----------------------------------------------------- 

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
)

YAY_PACKAGES=(
    "wlogout"
    "wev"
    "starship"
    "fastfetch"
    "visual-studio-code-bin"
)

clear

# Some colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Header
echo -e "${GREEN}"
cat <<"EOF"
 ____       _               
/ ___|  ___| |_ _   _ _ __  
\___ \ / _ \ __| | | | '_ \ 
 ___) |  __/ |_| |_| | |_) |
|____/ \___|\__|\__,_| .__/ 
                     |_|    

EOF

# ----------------------------------------------------- 
# Installation for Arch
# ----------------------------------------------------- 

# Function to install packages using pacman
install_pacman_packages() {
    echo "Installing packages from the official repository with pacman..."
    sudo pacman -Syu --noconfirm   # Sync and update system
    for package in "${PACMAN_PACKAGES[@]}"; do
        echo "Installing $package..."
        sudo pacman -S --noconfirm --needed "$package"
    done
}

# Function to install packages using yay
install_yay_packages() {
    echo "Installing AUR packages with yay..."
    yay -Syu --noconfirm  # Sync and update system
    for package in "${YAY_PACKAGES[@]}"; do
        echo "Installing $package..."
        yay -S --noconfirm "$package"
    done
}

# Check if pacman is installed
if ! command -v pacman &> /dev/null
then
    echo "Pacman is not installed. Please ensure you are using an Arch-based system."
    exit 1
fi

# Check if yay is installed
if ! command -v yay &> /dev/null
then
    echo "yay is not installed. Installing yay..."
    sudo pacman -S --noconfirm yay
fi

# Create Downloads folder if not exists
if [ ! -d ~/Downloads ] ;then
    mkdir ~/Downloads
    echo ":: Downloads folder created"
fi

if [ ! -d ~/Dev ] ;then
    mkdir ~/Dev
    echo ":: Dev folder created"
fi

# Change into Downloads directory
cd ~/Dev

# Remove existing folder
if [ -d ~/Dev/hyprland ] ;then
    rm -rf ~/Dev/hyprland
    echo ":: Existing installation folder removed"
fi

# Clone the packages
git clone --depth 1 https://github.com/Jimb0nda/hyprland.git
echo ":: Installation files cloned into Dev folder"

git clone --depth 1 https://github.com/Jimb0nda/Cpp.git
echo ":: Dev Projects cloned into Dev folder"

# Change into the folder
cd hyprland

# Run installation functions
install_pacman_packages
install_yay_packages
echo "All packages installed successfully."

#Copy config files from Git project to .config folder
cp -r dotfiles/.config/. ~/.config
