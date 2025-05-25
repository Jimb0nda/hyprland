read -rp "$(echo -e ${CYAN}${BOLD}Do you want to set up GitHub SSH? [Y/n]: ${RESET})" USE_SSH
USE_SSH=${USE_SSH:-Y}

if [[ "$USE_SSH" =~ ^[Yy]$ ]]; then
    info "Setting up GitHub SSH authentication..."

    GIT_NAME=$(git config --global user.name || true)
    if [ -z "$GIT_NAME" ]; then
        read -rp "$(echo -e ${YELLOW}${BOLD}Git name not found. Enter your full name: ${RESET})" GIT_NAME
        [ -n "$GIT_NAME" ] && git config --global user.name "$GIT_NAME" && success "Git name set to $GIT_NAME" || warn "No Git name provided. Skipping Git setup."
    else
        info "Git name detected: $GIT_NAME"
    fi

    GIT_EMAIL=$(git config --global user.email || true)
    if [ -z "$GIT_EMAIL" ]; then
        read -rp "$(echo -e ${YELLOW}${BOLD}Git email not found. Enter your GitHub email: ${RESET})" GIT_EMAIL
        [ -n "$GIT_EMAIL" ] && git config --global user.email "$GIT_EMAIL" && success "Git email set to $GIT_EMAIL" || warn "No Git email provided. Skipping Git setup."
    else
        info "Git email detected: $GIT_EMAIL"
    fi

    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_ed25519 -N ""
    success "SSH key generated"

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    success "SSH key added to agent"

    info "Your public SSH key:"
    echo -e "${YELLOW}"
    cat ~/.ssh/id_ed25519.pub
    echo -e "${RESET}"

    info "Opening GitHub SSH key page..."
    if command -v xdg-open &>/dev/null; then
        xdg-open "https://github.com/settings/ssh/new"
    elif command -v open &>/dev/null; then
        open "https://github.com/settings/ssh/new"
    fi

    read -rp "$(echo -e ${YELLOW}${BOLD}Press ENTER after adding the key to GitHub...${RESET})"

    info "Testing SSH connection..."
    if ssh -o StrictHostKeyChecking=no -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        success "SSH connection to GitHub confirmed!"
    else
        error "SSH authentication failed. Please check your GitHub key setup."
        USE_SSH=N  # fallback to HTTPS if it fails
    fi
else
    info "Skipping SSH setup. Repositories will be cloned using HTTPS."
fi


info "Cloning Dev Projects"
cd ~/dev

# Set clone base
if [[ "$USE_SSH" =~ ^[Yy]$ ]]; then
    BASE_URL="git@github.com:Jimb0nda"
else
    BASE_URL="https://github.com/Jimb0nda"
fi

# Hyprland
[[ -d "hyprland" ]] && rm -rf hyprland
git clone --depth 1 "$BASE_URL/hyprland.git"

# csharp
[[ -d "csharp" ]] && rm -rf csharp
git clone --depth 1 "$BASE_URL/csharp.git"

# cpp
[[ -d "cpp" ]] && rm -rf cpp
git clone --depth 1 "$BASE_URL/cpp.git"

# ml
[[ -d "ml" ]] && rm -rf ml
git clone --depth 1 "$BASE_URL/ml.git"

# Set remotes if using SSH
if [[ "$USE_SSH" =~ ^[Yy]$ ]]; then
    cd hyprland && git remote set-url origin git@github.com:Jimb0nda/hyprland.git && cd ..
fi

success "Dev projects cloned using ${USE_SSH}."

