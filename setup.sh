#!/bin/bash

source scripts/logging.sh

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
echo -e "${RESET}"

source scripts/install_git.sh

# Set up directories
mkdir -p ~/dev ~/documents ~/pictures
success "Directories added (Dev, Documents, Pictures)"

# Clone repositories
info "Cloning Hyprland Project"
cd ~/dev
[[ -d "hyprland" ]] && rm -rf hyprland
git clone --depth 1 https://github.com/Jimb0nda/hyprland.git
success "Hyprland Project cloned"

# Ensure .config directory exists
mkdir -p ~/.config

info "Entering Hyprland Folder for further install"
cd hyprland
source install.sh && success "Hyprland install script executed."

source scripts/create_symlinks.sh

# Reload Bash configuration
info "Sourcing bashrc"
source ~/.bashrc

info "Enabling system services to start on boot..."
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
success "NetworkManager and Bluetooth services enabled."

source scripts/setup_ssh.sh

info "Cloning Catppuccin for tmux"
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Setting up fingerprint service for enrollment after reboot
info "Setting up one-time fingerprint enrollment autostart..."
chmod +x ~/dev/hyprland/scripts/enroll_fingerprint.sh
mkdir -p ~/.config/autostart
cp ~/dev/hyprland/config/fingerprint/enroll-fingerprint.desktop ~/.config/autostart/enroll-fingerprint.desktop
success "Fingerprint enrollment will prompt at next login."


success "Setup complete!"

if [ "$ERROR_OCCURRED" -eq 1 ]; then
    error "Errors were detected during setup. Please check the log file:"
    echo -e "${YELLOW}${BOLD}$LOGFILE${RESET}"
    exit 1
else
    info "No errors detected. Rebooting in 5 seconds..."
    for i in {5..1}; do
        echo -ne "${YELLOW}${BOLD}Rebooting in $i seconds...${RESET} \r"
        sleep 1
    done
    sudo reboot
fi
