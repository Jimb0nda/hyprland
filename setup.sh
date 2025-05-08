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

# Check if git is installed
if ! command -v git &>/dev/null; then
    sudo pacman -S git --noconfirm
fi

# Set up directories
mkdir -p ~/Downloads ~/Dev
echo ":: Directories ensured (Downloads, Dev)"

# Clone repositories
cd ~/Dev
[[ -d "hyprland" ]] && rm -rf hyprland
git clone --depth 1 https://github.com/Jimb0nda/hyprland.git

[[ -d "Cpp" ]] && rm -rf Cpp
git clone --depth 1 https://github.com/Jimb0nda/Cpp.git

[[ -d "ML" ]] && rm -rf ML
git clone --depth 1 https://github.com/Jimb0nda/ML.git
echo ":: Dev Projects cloned"

# Ensure .config directory exists
mkdir -p ~/.config

cd hyprland
./install.sh

# Reload Bash configuration
source ~/.bashrc

echo ":: Setup complete!"

