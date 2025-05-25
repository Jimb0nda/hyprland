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

info "Checking Git is installed"
# Check if git is installed
if ! command -v git &>/dev/null; then
    warn "Git not found. Installing Git..."
    sudo pacman -S git --noconfirm
    success "Git installed successfully."
else
    success "Git is already installed."
fi

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

bash setup.sh

