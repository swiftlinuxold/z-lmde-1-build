#!/bin/bash
# Proper header for a Bash script.

# Check for root user login
if [ ! $( id -u ) -eq 0 ]; then
	echo "You must be root to run this script."
	echo "Please enter su before running this script again."
	exit 2
fi

# Get your username (not root)
UNAME=$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)
DIR_DEVELOP=''

# The remastering process uses chroot mode.
# Check to see if this script is operating in chroot mode.
# /home/mint directory only exists in chroot mode
IS_CHROOT=0
if [ -d "/home/mint" ]; then
	IS_CHROOT=1 # in chroot mode
	DIR_DEVELOP=/usr/local/bin/develop 
else
	DIR_DEVELOP=/home/$UNAME/develop 
fi

# Everything up to this point is common to the script shared-*.sh and all Bash scripts called by shared-*.sh
# ==========================================================================================================

# This is the script for transforming LMDE into Regular Swift Linux.

# Setting up apt-get/Synaptic MUST come first, because
# some repositories require installing packages.
python $DIR_DEVELOP/apt/main.py
python $DIR_DEVELOP/browser/main.py
python $DIR_DEVELOP/add_apps/main.py

python $DIR_DEVELOP/ui-login/main.py
# python $DIR_DEVELOP/ui-gnome/main.py
python $DIR_DEVELOP/ui-de/main.py
python $DIR_DEVELOP/ui-menu/main.py
# python $DIR_DEVELOP/1-build/cosmetic-regular.py

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

sh $DIR_DEVELOP/1-build/final.sh

exit 0
