#!/bin/bash

echo "Starting setup..."

# Install all packages
echo "Installing packages..."
sudo pacman -S --noconfirm \
    feh \
    picom \
    rofi \
    htop \
    fastfetch \
    powertop \
    alacritty \
    firefox \
    git \
    nodejs \
    npm \
    python \
    python-pip \
    intel-media-driver \
    libva-utils \
    timeshift \
    thunar \
    flameshot \
    i3-wm \
    i3blocks \
    i3lock \
    i3status \
    lightdm \
    lightdm-gtk-greeter \
    networkmanager \
    tlp \
    tlp-rdw \
    thermald \
    earlyoom \
    unzip \
    zip \
    nano \
    reflector

# Install AUR packages
echo "Installing AUR packages..."
paru -S --noconfirm \
    visual-studio-code-bin \
    paru

# Copy config files
echo "Copying config files..."
mkdir -p ~/.config/i3
cp ~/dotfiles/i3-config ~/.config/i3/config
cp ~/dotfiles/.bash_profile ~/.bash_profile
cp ~/dotfiles/.bashrc ~/.bashrc

# Enable services
echo "Enabling services..."
sudo systemctl enable lightdm
sudo systemctl enable NetworkManager
sudo systemctl enable tlp
sudo systemctl enable thermald
sudo systemctl enable earlyoom

echo "Done! Please reboot your system."
