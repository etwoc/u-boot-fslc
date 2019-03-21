#!/bin/bash

source /opt/yocto/2.4.2/environment-setup-armv7at2hf-neon-fslc-linux-gnueabi

BOARD=$1
SD=$3

echo "Board type is" $BOARD


if [ "sc100" == "$1" ]; then
	IMX6TYPE="mx6ul_sc100_defconfig"
elif [ "sc200" == "$1" ]; then
	IMX6TYPE="mx6_sc200_defconfig"
elif [ "playgo" == "$1" ]; then
	IMX6TYPE="mx6ul_playgo_defconfig"
elif [ "sc100_02" == "$1" ]; then
	IMX6TYPE="mx6ul_sc100_02_defconfig"
else
	echo "No board selected"
	exit 0
fi

if [ "build" == "$2" ]; then
	echo "Config file is " $IMX6TYPE
    make mrproper
	make $IMX6TYPE
	make

elif [ "install" == "$2" ]; then
    echo "Installing U-Boot to SD card"
	sudo dd if=SPL of=/dev/"$3" bs=1k seek=1;sync
	sudo dd if=u-boot.img of=/dev/"$3" bs=1k seek=69;sync
    
else
	echo "No action selected"
	exit 0
fi
