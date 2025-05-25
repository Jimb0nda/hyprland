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

bash setup.sh

