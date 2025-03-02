#!/bin/bash

# Set up colors
GREEN='\033[0;32m'
NONE='\033[0m'

clear
echo -e "${GREEN}"
cat <<"EOF"
 ____       _               
/ ___|  ___| |_ _   _ _ __  
\___ \ / _ \ __| | | | '_ \ 
 ___) |  __/ |_| |_| | |_) |
|____/ \___|\__|\__,_| .__/ 
                     |_|    

EOF

# Set up directories
mkdir -p ~/Downloads ~/Dev
echo ":: Directories ensured (Downloads, Dev)"

# Clone repositories
cd ~/Dev
[[ -d "hyprland" ]] && rm -rf hyprland
git clone --depth 1 https://github.com/Jimb0nda/hyprland.git
echo ":: Hyprland setup cloned"

[[ -d "Cpp" ]] && rm -rf Cpp
git clone --depth 1 https://github.com/Jimb0nda/Cpp.git
echo ":: Dev Projects cloned"

# Load and run package installation
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
bash "$SCRIPT_DIR/scripts/install_packages.sh"

# Ensure .config directory exists
mkdir -p ~/.config

# Create symbolic links for .config files
echo ":: Creating symlinks for config files..."
ln -sf ~/Dev/hyprland/dotfiles/.config/* ~/.config/
echo ":: Symlinks created for .config files."

# Create symbolic link for .bashrc
if [ -f ~/.bashrc ] || [ -L ~/.bashrc ]; then
    rm ~/.bashrc
fi
ln -s ~/Dev/hyprland/dotfiles/.bashrc ~/.bashrc
echo ":: Symlink created for .bashrc."

# Reload Bash configuration
source ~/.bashrc

echo ":: Setup complete!"

