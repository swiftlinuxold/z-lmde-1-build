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

def exec_script (repository):
    os.system ('python ' + dir_develop + '/' + repository + '/main.py')

# Setting up apt-get/Synaptic MUST come first, because
# some repositories require installing packages.
exec_script ('apt')

# Set up user interface
exec_script ('ui-login')
exec_script ('ui-de')
exec_script ('ui-menu')

# Set up control center
exec_script ('ui-config-network')
exec_script ('ui-config-info')
exec_script ('ui-config-printer')
exec_script ('ui-config-software')
exec_script ('ui-config-wallpaper')

# Add security features
exec_script ('security')

# Add installer
exec_script ('installer')

# Replace Firefox with Iceweasel, add ad-blocking app
# Does not work if executed after /add-misc/main.py
#exec_script ('browser')

# Add lightweight apps
#exec_script ('add-misc')

# Remove heavyweight apps
# Deactivate these commands to save time when testing
#exec_script ('remove-java') # Remove selected Java and LibreOffice packages
#exec_script ('remove-gnome') # Remove GNOME packages
#exec_script ('remove-misc') # Remove misc packages

# Add forensic features
#exec_script ('forensic')

# Final touches
exec_script ('final') # Must come last
