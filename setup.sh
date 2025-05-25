#!/bin/bash

# Set up colors
# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

info() {
    echo -e "${CYAN}${BOLD}:: $1${RESET}"
}

success() {
    echo -e "${GREEN}${BOLD}✔ $1${RESET}"
}

warn() {
    echo -e "${YELLOW}${BOLD}⚠ $1${RESET}"
    echo ":: WARN: $1" >> "$LOGFILE"
}

error() {
    echo -e "${RED}${BOLD}✖ $1${RESET}"
    echo ":: ERROR: $1" >> "$LOGFILE"
    ERROR_OCCURRED=1
}

#Create log file for caught errors
LOGFILE="$HOME/setup.log"
ERROR_OCCURRED=0

# Catch errors and set error flag
trap 'catch_error $? $LINENO "$BASH_COMMAND"' ERR

catch_error() {
    local code="$1"
    local lineno="$2"
    local cmd="$3"

    echo -e "\n${RED}${BOLD}✖ Error on line $lineno (exit code $code): $cmd${RESET}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') :: ERROR on line $lineno (exit $code): $cmd" >> "$LOGFILE"
    ERROR_OCCURRED=1
}

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

info "Entering Hyprland Folder for further install"
cd hyprland

source scripts/install_functions.sh

# Run package installation
info "Installing required packages..."
source scripts/install_packages.sh && success "Hyprland install script executed."

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
