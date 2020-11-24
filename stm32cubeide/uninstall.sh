#!/bin/bash

# This script is supposed to be located at the root of the
# STM32CubeIDE installation and all invoked scripts should be at the same location.
installdir=$(dirname $(readlink -m $0))

previousdir=$PWD
cd $installdir

if [ -f segger-jlink-udev-rules.uninstall.sh ]; then
	read -p "Uninstall SEGGER J-Link udev rules? [N/y] " answer
	if [ "$answer" = "y" ]; then
		sudo ./segger-jlink-udev-rules.uninstall.sh
	fi
fi

if [ -f st-stlink-udev-rules.uninstall.sh ]; then
	read -p "Uninstall ST-LINK udev rules? [N/y] " answer
	if [ "$answer" = "y" ]; then
		sudo ./st-stlink-udev-rules.uninstall.sh
	fi
fi

if [ -f stlink-server.uninstall.sh ]; then
	read -p "Uninstall stlink-server? [N/y] " answer
	if [ "$answer" = "y" ]; then
		sudo ./stlink-server.uninstall.sh
	fi
fi

if [ -f $(cat desktop_file_location.txt) ]; then
	read -p "Remove STM32CubeIDE desktop shortcut [N/y] " answer
	if [ "$answer" = "y" ]; then
		sudo rm $(cat desktop_file_location.txt)
	fi
fi

echo "Removing STM32CubeIDE..."
# Remove self.
cd ..
rm -rf $installdir
