#!/bin/bash
# Proper header for a Bash script.

# Check for root user login
if [ $( id -u ) -eq 0 ]; then
	echo "You must NOT be root to run this script."
	exit 2
fi

# Get your username (not root)
UNAME=$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)
DIR_DEVELOP=/home/$UNAME/develop

echo "=================================="
echo "BEGIN GIT CHECKING ALL DIRECTORIES"

DIR_LIST=$(ls -1 $DIR_DEVELOP)

for item in $DIR_LIST
do
    cd $DIR_DEVELOP/$item
    echo "------------"
    echo "Repository: " $item
    git status
done

echo "FINISHED GIT CHECKING ALL DIRECTORIES"
echo "====================================="

exit 0
