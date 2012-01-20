#!/bin/bash
# Proper header for a Bash script.

# Check for root user login
if [ ! $( id -u ) -eq 0 ]; then
	echo "You must be root to run this script."
	echo "Please enter su before running this script again."
	exit
fi

# Get your username (not root)
UNAME=$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)
DIR_DEVELOP=/home/$UNAME/develop

# Obtain the base ISO file
mount -t vboxsf guest /mnt/host
BASE_ISO=/mnt/host/linuxmint-201109-gnome-dvd-32bit.iso
while [ ! -f $BASE_ISO ];
	do
    echo "Could not find your $BASE_ISO file."
    echo "Please go to your host OS and copy"
    echo "$BASE_ISO \nto the /home/(username)/guest directory."
    echo "Press Enter when you are finished."
    read CD
    mount -t vboxsf guest /mnt/host
	done

# This is the script for transforming LMDE into Swift Linux on the desktop.

su -c "sh $DIR_DEVELOP/1-build/preinstall.sh" $UNAME

# rm -r $DIR_DEVELOP/temp
su -c "mkdir $DIR_DEVELOP/temp" $UNAME
# sh $DIR_DEVELOP/remaster/main.sh | tee -a $DIR_DEVELOP/temp/screenoutput.txt
sh $DIR_DEVELOP/remaster/main.sh
# chown $UNAME:users $DIR_DEVELOP/temp/screenoutput.txt
