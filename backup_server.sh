#! /bin/bash

# make directory if it doesn't exist
[ -d "output"  ] || mkdir output

# Home\ Videos: the "\ " represents space
for folder in Backups Documents Downloads Dump Home\ Videos Imports Matt\ Stuff Movies Music Pictures Steven TV
do
    echo "========================================================="
    echo "======================== $folder ========================"
    echo "========================================================="
    sudo rsync -havzP --stats /mnt/Server/$folder/* /mnt/e/Server/$folder | tee output/output_$folder.txt
done

