#! /bin/bash

###################################################
# Function: mount USB drive to /mnt/usb folder    #
# Tasks:                                          #
#   - Append fstab file                           #
#   - Create /mnt/Network/$folder folders         #
#   - Install prereqs if needed                   #
#   - Mount HDA smb folders to /mnt/Network/*     #
# Script using neatshell's template               #
# https://gist.github.com/neatshell/5283811       #
###################################################
# Source: https://vitux.com/how-to-manually-mount-unmount-a-usb-device-on-ubuntu/

##################
# Infor for User #
##################
# Check if running with sudo
if [[ $EUID -ne 0 ]]
  then echo "Please run with sudo"
  exit
fi

# make directory if it doesn't exist
[ -d "/mnt/usb"  ] || mkdir /mnt/usb

# print all lines that have "sd"
# and the next 4 lines, so user can look for sdb
fdisk -l | grep -A 4 sd

#################
#   User Input  #
#################
echo "-----------------------------"
read -p "Type the disk name: " disk
echo ""

read -p "ntfs, fat, or hfs? " file_type
echo ""
echo "-----------------------------"
echo ""

###################
# Mount USB Drive #
###################
if [ $file_type = "ntfs"  ]
then
    apt-get install cifs-utils
    mount -t ntfs-3g /dev/$disk /mnt/usb
    echo "Mounted to /mnt/usb"
    echo ""
    ls /mnt/usb
elif [ $file_type = "fat" ]
then
    echo "fat filesystem supported by default"
    mount -t vfat /dev/$disk /mnt/usb
    echo "Mounted to /mnt/usb"
    echo ""
    ls /mnt/usb
elif [ $file_type = "hfs" ]
then
    apt-get install hfsprogs
    mount -t hfsplus /dev/$disk /mnt/usb
    echo "Mounted to /mnt/usb"
    echo ""
    ls /mnt/usb
else
    echo "Unknown filetype. Please submit ntfs or fat"
    echo ""
fi
