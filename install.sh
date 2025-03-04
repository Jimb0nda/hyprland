
source scripts/install_functions.sh

# Run package installation
echo ":: Installing required packages..."
source scripts/install_packages.sh


#Run symlink script
echo ":: running Symlink Script"
source scripts/create_symlinks.sh
