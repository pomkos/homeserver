#! /bin/bash
# Guides you through mounting an external USB drive on Ubuntu
# Source: https://vitux.com/how-to-manually-mount-unmount-a-usb-device-on-ubuntu/

if [[ $EUID -ne 0 ]]
  then echo "Please run as root"
  exit
fi

# make directory if it doesn't exist
[ -d "/mnt/usb"  ] || mkdir /mnt/usb

fdisk -l | grep -A 4 sd

echo "-----------------------------"
read -p "Type the disk name: " disk
echo ""

read -p "ntfs or fat? " file_type
echo ""
echo "-----------------------------"
echo ""

if [ $file_type = "ntfs"  ]
then
    mount -t ntfs-3g /dev/$disk /mnt/usb
    echo "Mounted to /mnt/usb"
    echo ""
elif [ $file_type = "fat" ]
then
    mount -t vfat/dev/$disk /mnt/usb
    echo "Mounted to /mnt/usb"
    echo ""
else
    echo "Unknown filetype. Please submit ntfs or fat"
    echo ""
fi
