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
git clone --depth 1 git@github.com:Jimb0nda/hyprland.git

[[ -d "Cpp" ]] && rm -rf Cpp
git clone --depth 1 git@github.com:Jimb0nda/Cpp.git

[[ -d "ML" ]] && rm -rf ML
git clone --depth 1 git@github.com:Jimb0nda/ML.git
echo ":: Dev Projects cloned"

# Ensure .config directory exists
mkdir -p ~/.config

cd hyprland
./install.sh

# Create symbolic links for .config files, copy directories
echo ":: Creating symlinks for config files..."
# Loop through all files and directories in the source directory

for files in ~/Dev/hyprland/dotfiles/.config/*; do
    # Variable to concatenate
    target="$HOME/.config/"

    # Loop through all files and directories recursively
    find "$files" -print | while read file; do
        if [[ -d "$file" ]]; then
            # Extract relative path (everything after ".config/")
            relative_path=$(echo "$file" | sed 's|.*.config/||')
            # Result
            target_path="${target}${relative_path}"

            if [[ -d "$target_path" ]]; then
                echo ":: Directory found"
            elif [[ ! -d "$target_path" ]]; then
                echo ":: No directory found"     
                mkdir -p "$target_path"
                echo ":: Directory added"
            fi

        elif [[ ! -d "$file" ]]; then           
            # Extract relative path (everything after ".config/")
            relative_path=$(echo "$file" | sed 's|.*.config/||') 
            # Result
            target_path="${target}${relative_path}"

            if [[ -f "$target_path" ]]; then
                echo ":: File found"
                echo ":: Removing existing $target_path"
                rm -rf "$target_path"
                ln -s "$file" "$target_path"
                echo ":: Symlinked $item -> $target_path"
            elif [[ ! -f "$target_path" ]]; then
                echo ":: No File found"
                ln -s "$file" "$target_path"
                echo ":: Symlinked $file -> $target_path"
            fi
        fi
    done
done
echo ":: Symlinks and directories created for .config files."

# Create symbolic link for .tmux.conf
if [ -f ~/.tmux.conf ] || [ -L ~/.tmux.conf ]; then
    echo ":: Removing existing ~/.tmux.conf"
    rm ~/.tmux.conf
fi
ln -s ~/Dev/hyprland/dotfiles/.tmux.conf ~/.tmux.conf
echo ":: Symlink created for .tmux.conf"

# Create symbolic link for .bashrc
if [ -f ~/.bashrc ] || [ -L ~/.bashrc ]; then
    echo ":: Removing existing ~/.bashrc"
    rm ~/.bashrc
fi
ln -s ~/Dev/hyprland/dotfiles/.bashrc ~/.bashrc
echo ":: Symlink created for .bashrc."

sudo cp -r /home/james/Dev/hyprland/config/login/sugar-candy /usr/share/sddm/themes/
echo ":: Theme folder copied"

if [ -f /lib/sddm/sddm.conf.d/default.conf ] || [ -L /lib/sddm/sddm.conf.d/default.conf ]; then
    echo ":: Removing existing theme default.conf"
    sudo rm /lib/sddm/sddm.conf.d/default.conf
fi
sudo ln -s /home/james/Dev/hyprland/config/login/default.conf /lib/sddm/sddm.conf.d/default.conf
echo ":: Symlink of theme file created"

# Reload Bash configuration
source ~/.bashrc

echo ":: Setup complete!"

