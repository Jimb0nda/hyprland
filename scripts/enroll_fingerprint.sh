#!/bin/bash

# Optional: bring in your color helpers
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

info() { echo -e "${CYAN}${BOLD}:: $1${RESET}"; }
success() { echo -e "${GREEN}${BOLD}✔ $1${RESET}"; }

read -rp "$(echo -e ${CYAN}${BOLD}Do you want to enroll a fingerprint now? [Y/n]: ${RESET})" ENROLL_FP
ENROLL_FP=${ENROLL_FP:-Y}  # Default to Y

if [[ "$ENROLL_FP" =~ ^[Yy]$ ]]; then
    info "Starting fingerprint enrollment..."
    fprintd-enroll
    success "Fingerprint enrollment completed (if scanner available)."
else
    info "Skipped fingerprint enrollment."
fi

# Remove autostart entry to make this one-time
rm -f ~/.config/autostart/enroll-fingerprint.desktop

