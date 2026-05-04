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

# Install Hyprland packages
echo "Installing Hyprland packages..."
sudo pacman -S --noconfirm \
    hyprland \
    hyprpaper \
    waybar \
    wofi \
    kitty \
    dunst \
    pipewire \
    pipewire-audio \
    pipewire-pulse \
    wireplumber \
    polkit-gnome \
    xdg-desktop-portal-hyprland \
    wl-clipboard \
    cliphist \
    grim \
    slurp \
    swaybg \
    brightnessctl \
    playerctl \
    ttf-jetbrains-mono-nerd \
    gnome-themes-extra \
    power-profiles-daemon \
    hyprlock

# Install Hyprland AUR packages
echo "Installing Hyprland AUR packages..."
paru -S --noconfirm wlogout

# Copy Hyprland configs
echo "Copying Hyprland config files..."
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/kitty
mkdir -p ~/.config/dunst
cp -r ~/dotfiles/hyprland/hypr/* ~/.config/hypr/
cp -r ~/dotfiles/hyprland/waybar/* ~/.config/waybar/
cp -r ~/dotfiles/hyprland/kitty/* ~/.config/kitty/
cp -r ~/dotfiles/hyprland/dunst/* ~/.config/dunst/

# Enable Hyprland services
echo "Enabling Hyprland services..."
sudo systemctl enable power-profiles-daemon
systemctl --user enable pipewire-pulse

echo "Done! Please reboot your system."
