#!/bin/bash

echo "Cleaning package cache..."
sudo pacman -Sc --noconfirm

echo "Cleaning AUR cache..."
yay -Sc --noconfirm

echo "Cleaning journal logs older than 7 days..."
sudo journalctl --vacuum-time=7d

echo "Cleaning trash..."
rm -rf ~/.local/share/Trash/*

echo "Done! Freed up space."
df -h ~

