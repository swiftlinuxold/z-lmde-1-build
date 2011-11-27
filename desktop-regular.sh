#!/bin/bash
# Proper header for a Bash script.

# Check for root user login
if [ ! $( id -u ) -eq 0 ]; then
	echo "You must be root to run this script."
	echo "Please enter su before running this script again."
	exit
fi

# $USER is root or your regular user name
# $USERNAME is your regular user name, EVEN when you execute as root
DIR_DEVELOP=/home/$USERNAME/develop

# This is the script for transforming antiX Linux into Swift Linux on the desktop.

su -c "sh $DIR_DEVELOP/1-build/preinstall-regular.sh" $USERNAME

rm -r $DIR_DEVELOP/temp
su -c "mkdir $DIR_DEVELOP/temp" $USERNAME
sh $DIR_DEVELOP/1-build/shared-regular.sh | tee $DIR_DEVELOP/temp/screenoutput.txt
chown $USERNAME:users $DIR_DEVELOP/temp/screenoutput.txt
