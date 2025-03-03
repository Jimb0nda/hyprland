#!/bin/bash

# Install Yay if not found
_installYay() {
    if ! command -v yay &>/dev/null; then
        echo "yay not found! Installing..."
        git clone https://aur.archlinux.org/yay-git.git ~/yay-git
        cd ~/yay-git
        makepkg -si --noconfirm
        cd ~
        rm -rf ~/yay-git
        echo "yay installed successfully."
    else
        echo "yay is already installed."
    fi
}

# Check if package is installed
_isInstalled() {
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
_installPackages() {
    toInstall=()
    for pkg; do
        # Debugging output to check if the package is already installed
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo "${pkg} is already installed. Skipping.";
            continue
        fi
        toInstall+=("${pkg}")
    done
    if [[ ${#toInstall[@]} -eq 0 ]]; then
        echo "All pacman packages are already installed."
        return
    fi
    # Show the packages that will be installed
    echo "Packages to be installed via pacman: ${toInstall[@]}"
    sudo pacman --noconfirm -S "${toInstall[@]}"
}

_installPackagesYay() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalledYay "${pkg}") == 0 ]]; then
            echo ":: ${pkg} is already installed.";
            continue;
        fi;
        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All packages are already installed.";
        return;
    fi;

    # printf "AUR packags not installed:\n%s\n" "${toInstall[@]}";
    yay --noconfirm -S "${toInstall[@]}";
}



