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
    "p7zip"
    "jq"
    "poppler"
    "fd"
    "ripgrep"
    "fzf"
    "zoxide"
    "imagemagick"
    "bat"
)

installer_yay=(
    "wlogout" 
)

# PLEASE NOTE: Add more packages at the end of the following command
_installPackages "${installer_packages[@]}";
_installPackagesYay "${installer_yay[@]}";
