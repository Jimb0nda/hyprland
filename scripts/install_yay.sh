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

