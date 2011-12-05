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

# This is the script for the final steps of the shared-*.sh scripts.
echo "================================================="
echo "Removing *.deb files from /var/cache/apt/archives"
rm /var/cache/apt/archives/*.deb

# Make sure everything in the /home/(username) directory is owned by the (username)
echo "======================================================"
echo "Make all files in /home/(username) owned by (username)"
if [ $IS_CHROOT -eq 0 ]; then
    chown -R $UNAME:users /home/$UNAME
else
	chown -R mint:users /home/mint
fi

exit 0
