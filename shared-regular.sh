#! /usr/bin/env python

# Check for root user login
import os, sys
if not os.geteuid()==0:
    sys.exit("\nOnly root can run this script\n")

# Get your username (not root)
import pwd
uname=pwd.getpwuid(1000)[0]

# The remastering process uses chroot mode.
# Check to see if this script is operating in chroot mode.
# /home/mint directory only exists in chroot mode
is_chroot = os.path.exists('/home/mint')
dir_develop=''
if (is_chroot):
	dir_develop='/usr/local/bin/develop'
	dir_user = '/home/mint'
else:
	dir_develop='/home/' + uname + '/develop'
	dir_user = '/home/' + uname

# Everything up to this point is common to all Python scripts called by shared-*.sh
# =================================================================================

# This is the script for transforming LMDE into Regular Swift Linux.

# Setting up apt-get/Synaptic MUST come first, because
# some repositories require installing packages.
python $DIR_DEVELOP/apt/main.py

python $DIR_DEVELOP/remove-libreoffice/main.py # Remove selected Java and LibreOffice packages
python $DIR_DEVELOP/add-misc/main.py
python $DIR_DEVELOP/browser/main.py

# Set up user interface
python $DIR_DEVELOP/ui-login/main.py
python $DIR_DEVELOP/ui-de/main.py
python $DIR_DEVELOP/ui-icons/main.py
python $DIR_DEVELOP/ui-menu/main.py
python $DIR_DEVELOP/ui-config/main.py

# python $DIR_DEVELOP/1-build/cosmetic-regular.py

python $DIR_DEVELOP/remove-gnome/main.py # Remove GNOME packages
python $DIR_DEVELOP/remove-misc/main.py # Remove misc packages
python $DIR_DEVELOP/remove-final/main.py # Must come second from last
sh $DIR_DEVELOP/1-build/final.sh # MUST come last

exit 0
