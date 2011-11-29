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
else:
	dir_develop='/home/'+uname+'/develop'

# Everything up to this point is common to all Python scripts called by shared-*.sh
# =================================================================================

# THIS IS THE SCRIPT FOR PROVIDING THE COSMETIC APPEARANCE OF REGULAR SWIFT LINUX.

import shutil
# Change the SLiM wallpaper
if (os.path.exists('/usr/share/slim/themes/swift/background.jpg')):
	os.remove('/usr/share/slim/themes/swift/background.jpg')
src = dir_develop + '/edition-regular/login-regular.jpg'
dest = '/usr/share/slim/themes/swift/background.jpg'
shutil.copy (src, dest)

# Change the ROX pinboard background

# Change the ROX wallpaper

# Change Conky
