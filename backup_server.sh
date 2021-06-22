#! /bin/bash
# Home\ Videos: the "\ " represents space
for folder in Pictures Home\ Videos TV Movies Music Test Import Documents Dump Backup
do
    echo "========================================================="
    echo "======================== $folder ========================"
    echo "========================================================="
    sudo rsync -havzP --stats /mnt/Server/$folder/* /mnt/e/Server/$folder | tee output.txt
done

