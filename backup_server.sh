#! /bin/bash
# Home\ Videos: the "\ " represents space
for folder in Backups Documents Downloads Dump Home\ Videos Imports Matt\ Stuff Movies Music Pictures Steven TV
do
    echo "========================================================="
    echo "======================== $folder ========================"
    echo "========================================================="
    sudo rsync -havzP --stats /mnt/Server/$folder/* /mnt/e/Server/$folder | tee output.txt
done

