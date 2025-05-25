info "Creating symlinks for config files..."
# Loop through all files and directories in the source directory

for files in ~/dev/hyprland/dotfiles/.config/*; do
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
                warn "No directory found for $target_path"     
                mkdir -p "$target_path"
                success "Directory added $target_path"
            fi

        elif [[ ! -d "$file" ]]; then           
            # Extract relative path (everything after ".config/")
            relative_path=$(echo "$file" | sed 's|.*.config/||') 
            # Result
            target_path="${target}${relative_path}"

            if [[ -f "$target_path" ]]; then
                rm -rf "$target_path"
                ln -s "$file" "$target_path"
                success "Symlinked $item -> $target_path"
            elif [[ ! -f "$target_path" ]]; then
                ln -s "$file" "$target_path"
                success "Symlinked $file -> $target_path"
            fi
        fi
    done
done
success ":: Symlinks and directories created for .config files."

# Create symbolic link for .tmux.conf
if [ -f ~/.tmux.conf ] || [ -L ~/.tmux.conf ]; then
    warn "Removing existing ~/.tmux.conf"
    rm ~/.tmux.conf
fi
ln -s ~/dev/hyprland/dotfiles/.tmux.conf ~/.tmux.conf
success "Symlink created for .tmux.conf"

# Create symbolic link for .bashrc
if [ -f ~/.bashrc ] || [ -L ~/.bashrc ]; then
    warn "Removing existing ~/.bashrc"
    rm ~/.bashrc
fi
ln -s ~/dev/hyprland/dotfiles/.bashrc ~/.bashrc
success "Symlink created for .bashrc."

sudo cp -r ~/dev/hyprland/config/login/sugar-candy /usr/share/sddm/themes/
info "Theme folder copied"

if [ -f /lib/sddm/sddm.conf.d/default.conf ] || [ -L /lib/sddm/sddm.conf.d/default.conf ]; then
    warn "Removing existing theme default.conf"
    sudo rm /lib/sddm/sddm.conf.d/default.conf
fi
sudo ln -s ~/dev/hyprland/config/login/default.conf /lib/sddm/sddm.conf.d/default.conf
success "Symlink of theme file created"

if [ -f /etc/pam.d/sddm ] || [ -L /etc/pam.d/sddm ]; then
    warn "Removing existing sddm file"
    sudo cp ~/dev/hyprland/config/fingerprint/sddm /etc/pam.d/sddm
fi
success ":: Copied sddm file"

if [ -f /etc/pam.d/system-auth ] || [ -L /etc/pam.d/system-auth ]; then
    warn "Removing existing system-auth file"
    sudo cp ~/dev/hyprland/config/fingerprint/system-auth /etc/pam.d/system-auth
fi
success "Copied system-auth file"

