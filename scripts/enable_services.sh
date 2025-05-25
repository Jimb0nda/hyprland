info "Enabling system services to start on boot..."
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
success "NetworkManager and Bluetooth services enabled."


