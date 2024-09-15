# ----------------------------------------------------- 
# Install packages 
# ----------------------------------------------------- 

installer_packages=(
    "waybar"
    "hyprpaper"
    "hyprlock"
    "firefox"
    "vim"
    "pavucontrol"
    "bluez-utils"
    "blueman"
    "wlogout"
    "yazi"
    "ffmpegthumbnailer"
    "fd"
    "ripgrep"
    "fzf"
    "bat"
    "brightnessctl"
)

installer_yay=(
    "wlogout"
    "wev"
    "starship"
    "fastfetch"
)

# PLEASE NOTE: Add more packages at the end of the following command
_installPackages "${installer_packages[@]}";
_installPackagesYay "${installer_yay[@]}";
