#!/bin/bash

# Load package lists and functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$SCRIPT_DIR/config/packages.sh"
source "$SCRIPT_DIR/scripts/install_functions.sh"

# Ensure yay is installed
_installYay

# Install required packages
echo ":: Installing system packages..."
_installPackages "${PACMAN_PACKAGES[@]}"

echo ":: Installing AUR packages..."
_installPackagesYay "${YAY_PACKAGES[@]}"

echo ":: Package installation complete!"

