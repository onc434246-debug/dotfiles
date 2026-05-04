#!/bin/bash

echo "What do you want to mount?"
echo "1) USB / Hard Drive (NTFS)"
echo "2) Phone (MTP)"
echo "3) Unmount USB / Hard Drive"
echo "4) Unmount Phone"
read -p "Enter choice [1-4]: " choice

if [ "$choice" == "1" ]; then
    echo ""
    echo "Detecting drives..."
    lsblk -o NAME,SIZE,TYPE,MOUNTPOINTS,LABEL
    echo ""
    read -p "Enter device name (e.g. sda1, sdb1): " device
    if [ ! -b "/dev/$device" ]; then
        echo "Device /dev/$device not found!"
        exit 1
    fi
    mkdir -p ~/harddrive
    sudo mount -t ntfs-3g /dev/$device ~/harddrive
    thunar ~/harddrive
    echo "Done! /dev/$device is mounted."

elif [ "$choice" == "2" ]; then
    echo "Make sure your phone is unlocked and set to File Transfer (MTP) mode!"
    mkdir -p ~/phone
    jmtpfs ~/phone
    thunar ~/phone
    echo "Done! Phone is mounted."

elif [ "$choice" == "3" ]; then
    sudo umount ~/harddrive
    echo "Done! USB/Hard Drive unmounted."

elif [ "$choice" == "4" ]; then
    fusermount -u ~/phone
    echo "Done! Phone unmounted."

else
    echo "Invalid choice. Exiting."
fi
