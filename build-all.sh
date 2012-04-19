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

python $DIR_DEVELOP/1-build/build-regular.py
python $DIR_DEVELOP/diet/build.py
python $DIR_DEVELOP/special/build.py 'ts' 'Taylor Swift Linux'
python $DIR_DEVELOP/special/build.py 'mn' 'Minnesota Swift Linux'
python $DIR_DEVELOP/special/build.py 'chi' 'Chicago Swift Linux'
python $DIR_DEVELOP/special/build.py 'sv' 'Silicon Valley Swift Linux'
