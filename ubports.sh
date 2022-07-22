# data/linux Touch Port
# Base Flashable With Erfan . Edit By Nobi Nobita

OUTFD=/proc/self/fd/$1;

# ui_print <text>
ui_print() { echo -e "ui_print $1\nui_print" > $OUTFD; }

## data/linux Touch Install For Sweet

# Remove Old File
rm -rf /data/ubuntu.img;

# Copy And Patch New File
mv -f /data/ubports/data/ubuntu.img /data/;
mv -f /data/ubports/data/boot.img /data/;

# Create Folder Mount
mkdir -p /data/linux/ubuntu;

# Mount *.img to Folder Mount
mount /data/ubuntu.img /data/linux/ubuntu;

# Flash Kernel
dd if=/dev/block/by-name/boot of=/data/boot.img

# Umount All *.img
umount /data/linux/ubuntu;

# Remove Install file
rm -rf /data/ubports;
rm -rf /data/linux;

## Install Done ##
