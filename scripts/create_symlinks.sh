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

            if [[ ! -d "$target_path" ]]; then
                echo ":: No directory found"     
                mkdir -p "$target_path"
                echo ":: Directory added $target_path"
            fi

        elif [[ ! -d "$file" ]]; then           
            # Extract relative path (everything after ".config/")
            relative_path=$(echo "$file" | sed 's|.*.config/||') 
            # Result
            target_path="${target}${relative_path}"

            if [[ -f "$target_path" ]]; then
                rm -rf "$target_path"
                ln -s "$file" "$target_path"
                echo ":: Symlinked $item -> $target_path"
            elif [[ ! -f "$target_path" ]]; then
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

if [ -f /etc/pam.d/sddm ] || [ -L /etc/pam.d/sddm ]; then
    echo ":: Removing existing sddm file"
    sudo cp /home/james/Dev/hyprland/config/fingerprint/sddm /etc/pam.d/sddm
fi
echo ":: Copied sddm file"

if [ -f /etc/pam.d/system-auth ] || [ -L /etc/pam.d/system-auth ]; then
    echo ":: Removing existing system-auth file"
    sudo cp /home/james/Dev/hyprland/config/fingerprint/system-auth /etc/pam.d/system-auth
fi
echo ":: Copied system-auth file"
