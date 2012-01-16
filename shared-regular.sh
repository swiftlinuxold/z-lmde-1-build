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
if [ -d "/usr/lib/live-installer" ]; then
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

python $DIR_DEVELOP/add-misc/main.py
python $DIR_DEVELOP/browser/main.py

# Set up user interface
python $DIR_DEVELOP/ui-login/main.py
python $DIR_DEVELOP/ui-de/main.py
# python $DIR_DEVELOP/ui-icons/main.py
python $DIR_DEVELOP/ui-menu/main.py
python $DIR_DEVELOP/ui-config/main.py

# python $DIR_DEVELOP/1-build/cosmetic-regular.py
# python $DIR_DEVELOP/remove-misc/main.py
# python $DIR_DEVELOP/ui-gnome/main.py # Remove GNOME packages, third from last
python $DIR_DEVELOP/remove-languages/main.py # Must come second from last
sh $DIR_DEVELOP/1-build/final.sh # MUST come last

exit 0
