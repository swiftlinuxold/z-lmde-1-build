#!/bin/bash
# Proper header for a Bash script.

# Check for root user login
if [ ! $( id -u ) -eq 0 ]; then
	echo "You must be root to run this script."
	echo "Please enter su before running this script again."
	exit 2
fi

# $USER is root or your regular user name
# $USERNAME is your regular user name, EVEN when you execute as root

# The remastering process uses chroot mode.
# Check to see if this script is operating in chroot mode.
# /srv directory only exists in chroot mode
IS_CHROOT=0
if [ -d "/home/mint" ]; then
	IS_CHROOT=1 # in chroot mode
	DIR_DEVELOP=/usr/local/bin/develop 
else
	DIR_DEVELOP=/home/$USERNAME/develop 
fi

# This is the script for transforming LMDE into Regular Swift Linux.

# Setting up apt-get/Synaptic MUST come first, because
# some repositories require installing packages.
#sh $DIR_DEVELOP/apt/main.sh 

sh $DIR_DEVELOP/ui/main.sh

#sh $DIR_DEVELOP/add_help/main.sh 
#sh $DIR_DEVELOP/conky/main.sh
#sh $DIR_DEVELOP/control_center/main.sh
#sh $DIR_DEVELOP/iceape/main.sh
#sh $DIR_DEVELOP/icewm/main.sh
#sh $DIR_DEVELOP/installer/main.sh
#sh $DIR_DEVELOP/mime/main.sh
#sh $DIR_DEVELOP/rox/main.sh
#sh $DIR_DEVELOP/security/main.sh
#sh $DIR_DEVELOP/slim/main.sh
#sh $DIR_DEVELOP/sylpheed/main.sh
#sh $DIR_DEVELOP/wallpaper-standard/main.sh

#sh $DIR_DEVELOP/remove_languages/main.sh
#sh $DIR_DEVELOP/remove_packages/main.sh


#sh $DIR_DEVELOP/1-build/remove_deb.sh # Removes stored *.deb files, must be executed last

exit 0
