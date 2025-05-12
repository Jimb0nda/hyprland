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
mkdir -p ~/Downloads ~/Dev ~/Documents ~/Pictures
success ":: Directories added (Downloads, Dev, Documents, Pictures)"

# Clone repositories
info ":: Cloning Hyprland Project"
cd ~/Dev
[[ -d "hyprland" ]] && rm -rf hyprland
git clone --depth 1 https://github.com/Jimb0nda/hyprland.git
success ":: Hyprland Project cloned"

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

sudo cp -r ~/Dev/hyprland/config/login/sugar-candy /usr/share/sddm/themes/
info ":: Theme folder copied"

if [ -f /lib/sddm/sddm.conf.d/default.conf ] || [ -L /lib/sddm/sddm.conf.d/default.conf ]; then
    warn ":: Removing existing theme default.conf"
    sudo rm /lib/sddm/sddm.conf.d/default.conf
fi
sudo ln -s ~/Dev/hyprland/config/login/default.conf /lib/sddm/sddm.conf.d/default.conf
success ":: Symlink of theme file created"

if [ -f /etc/pam.d/sddm ] || [ -L /etc/pam.d/sddm ]; then
    warn ":: Removing existing sddm file"
    sudo cp ~/Dev/hyprland/config/fingerprint/sddm /etc/pam.d/sddm
fi
success ":: Copied sddm file"

if [ -f /etc/pam.d/system-auth ] || [ -L /etc/pam.d/system-auth ]; then
    warn ":: Removing existing system-auth file"
    sudo cp ~/Dev/hyprland/config/fingerprint/system-auth /etc/pam.d/system-auth
fi
success ":: Copied system-auth file"

# Reload Bash configuration
info "Sourcing bashrc"
source ~/.bashrc

info "Enabling system services to start on boot..."
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
success "NetworkManager and Bluetooth services enabled."

# Setting up SSH for github if doesn't exist
if [ ! -f ~/.ssh/id_ed25519 ]; then
    info "Setting up GitHub SSH authentication..."

    # Get or prompt for Git name
    GIT_NAME=$(git config --global user.name || true)
    if [ -z "$GIT_NAME" ]; then
        read -rp "$(echo -e ${YELLOW}${BOLD}Git name not found. Enter your full name: ${RESET})" GIT_NAME
        if [ -n "$GIT_NAME" ]; then
            git config --global user.name "$GIT_NAME"
            success "Git name set to $GIT_NAME"
        else
            warn "No Git name provided. Skipping Git setup."
        fi
    else
        info "Git name detected: $GIT_NAME"
    fi
    
    # Get or prompt for Git email
    GIT_EMAIL=$(git config --global user.email || true)
    if [ -z "$GIT_EMAIL" ]; then
        read -rp "$(echo -e ${YELLOW}${BOLD}Git email not found. Enter your GitHub email: ${RESET})" GIT_EMAIL
        if [ -n "$GIT_EMAIL" ]; then
            git config --global user.email "$GIT_EMAIL"
            success "Git email set to $GIT_EMAIL"
        else
            warn "No Git email provided. Skipping Git setup."
        fi
    else
        info "Git email detected: $GIT_EMAIL"
    fi


    # Ensure ~/.ssh exists
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    # Generate SSH key
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_ed25519 -N ""
    success "SSH key generated for $GIT_EMAIL"

    # Start SSH agent and add key
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    success "SSH key added to SSH agent."

    # Show public key
    info "Your public SSH key (add this to GitHub):"
    echo -e "${YELLOW}"
    cat ~/.ssh/id_ed25519.pub
    echo -e "${RESET}"

    # Open GitHub key page
    info "Opening GitHub SSH key page..."
    if command -v xdg-open &> /dev/null; then
        xdg-open "https://github.com/settings/ssh/new"
    elif command -v open &> /dev/null; then
        open "https://github.com/settings/ssh/new"
    fi

    # Wait for user
    read -rp "$(echo -e ${YELLOW}${BOLD}Press ENTER after adding the SSH key to GitHub...${RESET})"

    # Test SSH connection
    info "Testing SSH connection to GitHub..."
    if ssh -o StrictHostKeyChecking=no -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        success "SSH connection to GitHub confirmed!"
    else
        error "SSH authentication to GitHub failed. Add your key to GitHub:"
        echo -e "${YELLOW}https://github.com/settings/ssh/new${RESET}"
        ERROR_OCCURRED=1
    fi
else
    info "SSH key already exists. Skipping GitHub SSH setup."
fi


info ":: Cloning Dev Projects"
cd ~/Dev
cd hyprland
git remote set-url origin git@github.com:Jimb0nda/hyprland.git
cd ..
# csharp
[[ -d "csharp" ]] && rm -rf csharp
git clone --depth 1 git@github.com:Jimb0nda/csharp.git
# Cpp
[[ -d "Cpp" ]] && rm -rf Cpp
git clone --depth 1 git@github.com:Jimb0nda/Cpp.git
# ML
[[ -d "ML" ]] && rm -rf ML
git clone --depth 1 git@github.com:Jimb0nda/ML.git
success ":: Dev Projects cloned and remote URLs set to SSH"

# Setting up fingerprint service for enrollment after reboot
info "Setting up one-time fingerprint enrollment autostart..."
chmod +x ~/Dev/hyprland/scripts/enroll_fingerprint.sh
mkdir -p ~/.config/autostart
cp ~/Dev/hyprland/config/fingerprint/enroll-fingerprint.desktop ~/.config/autostart/enroll-fingerprint.desktop
success "Fingerprint enrollment will prompt at next login."


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
