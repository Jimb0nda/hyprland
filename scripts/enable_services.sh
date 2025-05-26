info "Enabling system services to start on boot..."
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable libvirtd
sudo usermod -aG libvirt "$USER"
success "NetworkManager and Bluetooth services enabled."


