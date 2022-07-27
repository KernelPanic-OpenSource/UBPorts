# data/linux Touch Port
# Base Flashable With Erfan . Edit By Nobi Nobita

OUTFD=/proc/self/fd/$1;
CODENAME=$(getprop ro.product.device)

# ui_print <text>
ui_print() { echo -e "ui_print $1\nui_print" > $OUTFD; }

## data/linux Touch Install For Sweet

# Remove Old File
ui_print " Remove old rootfs";
rm -rf /data/ubuntu.img;
rm -rf /data/boot.img;

# Copy And Patch New File
ui_print " Copy new Ubuntu Touch and ETC";
mv -f /data/ubports/data/ubuntu.img /data/;
mv -f /data/ubports/data/boot.img /data/;
mv -f /data/ubports/data/firmware-sweet.zip /data/;
mv -f /data/ubports/data/firmware-sweetin.zip /data/;
mv -f /data/ubports/data/LineageOS.zip /data/;

# Flash vendor
ui_print " Flash LineageOS 18.1";
twrp install /data/LineageOS.zip;

# 8GB Rootfs
ui_print " Resizing rootfs to 8GB";
e2fsck -fy /data/ubuntu.img;
resize2fs -f /data/ubuntu.img 16G;

# Create Folder Mount
mkdir -p /data/linux/ubuntu;

# Mount *.img to Folder Mount
ui_print " Mount rootfs";
mount /data/ubuntu.img /data/linux/ubuntu;

# Udev
ui_print " Create rules";
cat /vendor/ueventd*.rc | grep ^/dev | sed -e 's/^\/dev\///' | awk '{printf "ACTION==\"add\", KERNEL==\"%s\", OWNER=\"%s\", GROUP=\"%s\", MODE=\"%s\"\n",$1,$3,$4,$2}' | sed -e 's/\r//' > /data/linux/ubuntu/etc/udev/rules.d/70-sweet.rules;

# Bootable
ui_print " Flash halium boot";
dd if=/data/boot.img of=/dev/block/by-name/boot;

# Flash Firmware
ui_print " Flash firmware";
if getprop ro.product.device | grep -Eqi "sweet"; then
    twrp install /data/firmware-sweet.zip
elif getprop ro.product.device | grep -Eqi "sweetin"; then
    twrp install /data/firmware-sweetin.zip
else
    ui_print "You need Flash Firmware bc this script can't detect you device.";
fi

# Umount All *.img
ui_print " Clean";
umount /data/linux/ubuntu;

# Remove Install file
rm -rf /data/ubports;
rm -rf /data/linux;
rm -rf /data/firmware-sweet.zip;
rm -rf /data/firmware-sweetin.zip;
rm -rf /data/LineageOS.zip;
rm -rf /data/boot.img;

## Install Done ##
