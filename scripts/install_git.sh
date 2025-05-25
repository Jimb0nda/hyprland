info "Checking Git is installed"
# Check if git is installed
if ! command -v git &>/dev/null; then
    warn "Git not found. Installing Git..."
    sudo pacman -S git --noconfirm
    success "Git installed successfully."
else
    success "Git is already installed."
fi


