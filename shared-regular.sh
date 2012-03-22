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
#=====================================================================================================

# This is the script for transforming LMDE into Regular Swift Linux.

# Setting up apt-get/Synaptic MUST come first, because
# some repositories require installing packages.
python $DIR_DEVELOP/apt/main.py

# Remove heavyweight apps
# Deactivate these commands to save time when testing
python $DIR_DEVELOP/remove-libreoffice/main.py # Remove selected Java and LibreOffice packages
python $DIR_DEVELOP/remove-gnome/main.py # Remove GNOME packages
python $DIR_DEVELOP/remove-misc/main.py # Remove misc packages

# Add lightweight apps (some needed for later steps in this process)
python $DIR_DEVELOP/add-misc/main.py

# Replace Firefox with Iceweasel, add ad-blocking app
# Does not work if executed after /add-misc/main.py
python $DIR_DEVELOP/browser/main.py

# Set up user interface
python $DIR_DEVELOP/ui-login/main.py
python $DIR_DEVELOP/ui-de/main.py
python $DIR_DEVELOP/ui-menu/main.py

# Set up control center
python $DIR_DEVELOP/ui-config-network/main.py
#python $DIR_DEVELOP/ui-config/main.py

# Add installer
python $DIR_DEVELOP/installer/main.py

# Add security features
python $DIR_DEVELOP/security/main.py

# Add forensic features
python $DIR_DEVELOP/forensic/main.py

# Final touches
python $DIR_DEVELOP/final/main.py # Must come last

exit 0
