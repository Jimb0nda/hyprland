#!/bin/bash

# Set up colors
# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

info() { echo -e "${CYAN}${BOLD}:: $1${RESET}"; }
success() { echo -e "${GREEN}${BOLD}✔ $1${RESET}"; }
warn() { echo -e "${YELLOW}${BOLD}⚠ $1${RESET}"; }
error() { echo -e "${RED}${BOLD}✖ $1${RESET}"; }

#Create log file for caught errors
LOGFILE="$HOME/setup.log"
ERROR_OCCURRED=0

# Log all output to terminal and log file
exec > >(tee -a "$LOGFILE") 2>&1

# Catch errors and set error flag
trap 'echo -e "\n${RED}${BOLD}✖ Error on line $LINENO. Check $LOGFILE for details.${RESET}"; ERROR_OCCURRED=1' ERR

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

info ":: Checking Git is installed"
# Check if git is installed
if ! command -v git &>/dev/null; then
    warn "Git not found. Installing Git..."
    sudo pacman -S git --noconfirm
    success "Git installed successfully."
else
    success "Git is already installed."
fi

# Set up directories
mkdir -p ~/Downloads ~/Dev ~/Documents
success ":: Directories added (Downloads, Dev, Documents)"

# Clone repositories
info ":: Cloning Dev Projects"
cd ~/Dev
[[ -d "hyprland" ]] && rm -rf hyprland
git clone --depth 1 https://github.com/Jimb0nda/hyprland.git

[[ -d "Cpp" ]] && rm -rf Cpp
git clone --depth 1 https://github.com/Jimb0nda/Cpp.git

[[ -d "ML" ]] && rm -rf ML
git clone --depth 1 https://github.com/Jimb0nda/ML.git
success ":: Dev Projects cloned"

# Ensure .config directory exists
mkdir -p ~/.config

info ":: Entering Hyprland Folder for further install"
cd hyprland
source install.sh && success "Hyprland install script executed."

info ":: Creating symlinks for config files..."
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
                warn ":: No directory found for $target_path"     
                mkdir -p "$target_path"
                success ":: Directory added $target_path"
            fi

        elif [[ ! -d "$file" ]]; then           
            # Extract relative path (everything after ".config/")
            relative_path=$(echo "$file" | sed 's|.*.config/||') 
            # Result
            target_path="${target}${relative_path}"

            if [[ -f "$target_path" ]]; then
                rm -rf "$target_path"
                ln -s "$file" "$target_path"
                success ":: Symlinked $item -> $target_path"
            elif [[ ! -f "$target_path" ]]; then
                ln -s "$file" "$target_path"
                success ":: Symlinked $file -> $target_path"
            fi
        fi
    done
done
success ":: Symlinks and directories created for .config files."

# Create symbolic link for .tmux.conf
if [ -f ~/.tmux.conf ] || [ -L ~/.tmux.conf ]; then
    warn ":: Removing existing ~/.tmux.conf"
    rm ~/.tmux.conf
fi
ln -s ~/Dev/hyprland/dotfiles/.tmux.conf ~/.tmux.conf
success ":: Symlink created for .tmux.conf"

# Create symbolic link for .bashrc
if [ -f ~/.bashrc ] || [ -L ~/.bashrc ]; then
    warn ":: Removing existing ~/.bashrc"
    rm ~/.bashrc
fi
ln -s ~/Dev/hyprland/dotfiles/.bashrc ~/.bashrc
success ":: Symlink created for .bashrc."

sudo cp -r /home/james/Dev/hyprland/config/login/sugar-candy /usr/share/sddm/themes/
info ":: Theme folder copied"

if [ -f /lib/sddm/sddm.conf.d/default.conf ] || [ -L /lib/sddm/sddm.conf.d/default.conf ]; then
    warn ":: Removing existing theme default.conf"
    sudo rm /lib/sddm/sddm.conf.d/default.conf
fi
sudo ln -s /home/james/Dev/hyprland/config/login/default.conf /lib/sddm/sddm.conf.d/default.conf
success ":: Symlink of theme file created"

if [ -f /etc/pam.d/sddm ] || [ -L /etc/pam.d/sddm ]; then
    warn ":: Removing existing sddm file"
    sudo cp /home/james/Dev/hyprland/config/fingerprint/sddm /etc/pam.d/sddm
fi
success ":: Copied sddm file"

if [ -f /etc/pam.d/system-auth ] || [ -L /etc/pam.d/system-auth ]; then
    warn ":: Removing existing system-auth file"
    sudo cp /home/james/Dev/hyprland/config/fingerprint/system-auth /etc/pam.d/system-auth
fi
success ":: Copied system-auth file"

# Reload Bash configuration
source ~/.bashrc

success ":: Setup complete!"

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
