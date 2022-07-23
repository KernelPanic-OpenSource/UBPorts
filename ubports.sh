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
mv -f /data/ubports/data/boot.img /data/halium.img;

# Create Folder Mount
mkdir -p /data/linux/ubuntu;

# Mount *.img to Folder Mount
mount /data/ubuntu.img /data/linux/ubuntu;

# Udev
cat /vendor/ueventd*.rc | grep ^/dev | sed -e 's/^\/dev\///' | awk '{printf "ACTION==\"add\", KERNEL==\"%s\", OWNER=\"%s\", GROUP=\"%s\", MODE=\"%s\"\n",$1,$3,$4,$2}' | sed -e 's/\r//' > /data/linux/ubuntu/etc/udev/rules.d/70-sweet.rules

# Bootable
dd if=/data/halium.img of=/dev/block/by-name/boot

# Umount All *.img
umount /data/linux/ubuntu;

# Remove Install file
rm -rf /data/ubports;
rm -rf /data/linux;

## Install Done ##
