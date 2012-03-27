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

# sh $DIR_DEVELOP/1-build/build-regular.sh
# sh $DIR_DEVELOP/diet/create-diet.sh

mkdir $DIR_DEVELOP/temp-output

# python $DIR_DEVELOP/special/build.py 'ts' 'Taylor Swift' | tee -a $DIR_DEVELOP/temp-output/build-ts.txt
python $DIR_DEVELOP/special/build.py 'ts' 'Taylor Swift'
