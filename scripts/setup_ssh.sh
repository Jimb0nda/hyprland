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


info "Cloning Dev Projects"
cd ~/dev
cd hyprland
git remote set-url origin git@github.com:Jimb0nda/hyprland.git
cd ..
# csharp
[[ -d "csharp" ]] && rm -rf csharp
git clone --depth 1 git@github.com:Jimb0nda/csharp.git
# Cpp
[[ -d "cpp" ]] && rm -rf cpp
git clone --depth 1 git@github.com:Jimb0nda/cpp.git
# ML
[[ -d "ml" ]] && rm -rf ml
git clone --depth 1 git@github.com:Jimb0nda/ml.git
success "Dev Projects cloned and remote URLs set to SSH"

