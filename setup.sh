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
for file in ~/Dev/hyprland/dotfiles/.config/*; do
    filename=$(basename "$file")
    target="$HOME/.config/$filename"

    # Check if it's a directory or a file
    if [[ -d "$file" ]]; then
        # If it's a directory, check if the target directory exists
        if [[ -d "$target" ]]; then
            # If the directory exists, remove all files in the directory
            echo ":: Directory exists: $target. Removing files and symlinking from source."
            rm -rf "$target"/*
        else
            # If the directory doesn't exist, create it
            echo ":: Creating directory: $target"
            mkdir -p "$target"
        fi
        # Recursively create symlinks for files inside the directory
        for item in "$file"/*; do
            ln_target="$target/$(basename "$item")"
            if [[ -e "$ln_target" || -L "$ln_target" ]]; then
                echo ":: Removing existing symlink or file at $ln_target"
                rm -rf "$ln_target"
            fi
            ln -s "$item" "$ln_target"
            echo ":: Symlinked $item -> $ln_target"
        done
    elif [[ -f "$file" ]]; then
        # If it's a file, create a symlink
        if [[ -e "$target" || -L "$target" ]]; then
            echo ":: Removing existing $target"
            rm -rf "$target"
        fi
        ln -s "$file" "$target"
        echo ":: Symlinked $file -> $target"
    fi
done
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

