#!/bin/bash

# Install Yay if not found
_installYay() {
    if ! command -v yay &>/dev/null; then
        echo "yay not found! Installing..."
        git clone https://aur.archlinux.org/yay-git.git ~/yay-git
        cd ~/yay-git
        makepkg -si --noconfirm
        cd ~
        rm -rf ~/yay-git
        echo "yay installed successfully."
    else
        echo "yay is already installed."
    fi
}

# Check if a package is installed via Pacman
_isInstalled() {
    local package="$1"
    pacman -Qi "$package" &>/dev/null && echo 0 || echo 1
}

# Check if a package is installed via Yay
_isInstalledYay() {
    local package="$1"
    yay -Q "$package" &>/dev/null && echo 0 || echo 1
}

# Install Pacman packages
_installPackages() {
    local toInstall=()
    for pkg in "$@"; do
        [[ $(_isInstalled "$pkg") == 0 ]] && echo ":: $pkg already installed." || toInstall+=("$pkg")
    done
    [[ "${#toInstall[@]}" -gt 0 ]] && sudo pacman --noconfirm -S "${toInstall[@]}"
}

# Install Yay packages
_installPackagesYay() {
    local toInstall=()
    for pkg in "$@"; do
        [[ $(_isInstalledYay "$pkg") == 0 ]] && echo ":: $pkg already installed." || toInstall+=("$pkg")
    done
    [[ "${#toInstall[@]}" -gt 0 ]] && yay --noconfirm -S "${toInstall[@]}"
}

