
source scripts/install_functions.sh

# Run package installation
echo ":: Installing required packages..."
source scripts/install_packages.sh


#Run symlink script
#echo ":: running Symlink Script"
#sleep 1
#if [ -f scripts/create_symlinks.sh ]; then
#    source scripts/create_symlinks.sh
#else
#    echo "Error: create_symlinks.sh not found!"
#fi
