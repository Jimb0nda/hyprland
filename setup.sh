#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/scripts/logging.sh"

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

source "$SCRIPT_DIR/scripts/install_functions.sh"
source "$SCRIPT_DIR/scripts/install_packages.sh"
source "$SCRIPT_DIR/scripts/create_symlinks.sh"
# Reload Bash configuration
#info "Sourcing bashrc"
#source ~/.bashrc
source "$SCRIPT_DIR/scripts/enable_services.sh"
source "$SCRIPT_DIR/scripts/setup_ssh.sh"
source "$SCRIPT_DIR/scripts/tmux_packages.sh"

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
