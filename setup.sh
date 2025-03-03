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
echo ":: Hyprland setup cloned"

[[ -d "Cpp" ]] && rm -rf Cpp
git clone --depth 1 https://github.com/Jimb0nda/Cpp.git
echo ":: Dev Projects cloned"

# Ensure .config directory exists
mkdir -p ~/.config

cd hyprland
./install.sh

# Create symbolic links for .config files, copy directories
echo ":: Creating symlinks for config files..."

process_directory() {
    local source_dir="$1"
    local target_dir="$2"

    # Iterate through the items in the directory
    for item in "$source_dir"/*; do
        local filename=$(basename "$item")
        local target="$target_dir/$filename"

        if [[ -d "$item" ]]; then
            # If it's a directory, recurse into it
            echo ":: Directory found: $item"
            if [[ ! -d "$target" ]]; then
                echo ":: Creating directory: $target"
                mkdir -p "$target"
            fi
            # Recursively process the subdirectory
            process_directory "$item" "$target"
        elif [[ -f "$item" ]]; then
            # If it's a file, create a symlink
            if [[ -e "$target" || -L "$target" ]]; then
                echo ":: Removing existing $target"
                rm -rf "$target"
            fi
            ln -s "$item" "$target"
            echo ":: Symlinked $item -> $target"
        fi
    done
}

# Start the process from the root directory
source_dir=~/Dev/hyprland/dotfiles/.config
target_dir=$HOME/.config

process_directory "$source_dir" "$target_dir"
echo ":: Symlinks and directories created for .config files."

# Create symbolic link for .bashrc
if [ -f ~/.bashrc ] || [ -L ~/.bashrc ]; then
    echo ":: Removing existing ~/.bashrc"
    rm ~/.bashrc
fi
ln -s ~/Dev/hyprland/dotfiles/.bashrc ~/.bashrc
echo ":: Symlink created for .bashrc."

# Reload Bash configuration
source ~/.bashrc

echo ":: Setup complete!"

