#!/bin/bash

# ----------------------------------------------------- 
# Functions for Setup
# ----------------------------------------------------- 

distro="arch"
installer="arch"

# Check if package is installed
_isInstalledPacman() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# Install required packages
_installPackagesPacman() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            echo "${pkg} is already installed.";
            continue;
        fi;
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All pacman packages are already installed.";
        return;
    fi;
    printf "Package not installed:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

# ----------------------------------------------------- 
# Packages
# ----------------------------------------------------- 

# Required packages for the installer on Arch
installer_packages_arch=(
    "figlet"
    "git"
)

# Required packages for the installer on Fedora
installer_packages_fedora=(
    "figlet"
    "git"
)

clear

# Some colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Header
echo -e "${GREEN}"
cat <<"EOF"
 ____       _               
/ ___|  ___| |_ _   _ _ __  
\___ \ / _ \ __| | | | '_ \ 
 ___) |  __/ |_| |_| | |_) |
|____/ \___|\__|\__,_| .__/ 
                     |_|    

EOF

# ----------------------------------------------------- 
# Installation for Arch
# ----------------------------------------------------- 
if [ "$installer" == "arch" ] ;then
    _installPackagesPacman "${installer_packages_arch[@]}";
fi

# Create Downloads folder if not exists
if [ ! -d ~/Downloads ] ;then
    mkdir ~/Downloads
    echo ":: Downloads folder created"
fi

if [ ! -d ~/Dev ] ;then
    mkdir ~/Dev
    echo ":: Dev folder created"
fi

# Change into Downloads directory
cd ~/Dev

# Remove existing folder
if [ -d ~/Dev/Hyprland ] ;then
    rm -rf ~/Dev/Hyprland
    echo ":: Existing installation folder removed"
fi

# Clone the packages
git clone --depth 1 https://github.com/Jimb0nda/Hyprland.git
echo ":: Installation files cloned into Dev folder"

git clone --depth 1 https://github.com/Jimb0nda/Cpp.git
echo ":: Dev Projects cloned into Dev folder"

# Change into the folder
cd Hyprland

# Start the script
source install/library.sh
source install/install_required.sh
source install/install_packages.sh

cp -r dotfiles/.config/. ~/.config