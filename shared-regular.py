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

# =============================================================================
# To save time for testing purposes, disable the commands in the section below.
# Do NOT disable the remove-* scripts without also disabling the update script.
# ============================================================================= 

# REMOVE HEAVYWEIGHT APPS HERE
# In the interest of saving time, this must be done BEFORE updating the pre-installed packages.
# If you leave these heavyweight apps installed, updating the setup takes MUCH longer. 
exec_script ('remove-java') # Remove selected Java and LibreOffice packages
exec_script ('remove-gnome') # Remove GNOME packages
exec_script ('remove-misc') # Remove misc packages

# REMOVE OTHER APPS HERE
# Need to separate the removal of Firefox and the addition/configuration of Iceweasel
# and move the Iceweasel part to after the updates.
# Need to split the removal of the Linux Mint wallpaper from ui-config-wallpaper script
# and move it to this section.
exec_script ('browser')

# UPDATE THE SETUP HERE
# Timing is key for updates.
# If the updates are too early, then packages to be deleted are unnecessarily updated.
# If the updates are too late, changes made by Swift Linux scripts to pre-installed packages 
# are wiped out.
# To save time for testing purposes, disable the updates AND the section above.
# If you disable the section above but leave the updating enabled, 
# the process will take MUCH longer.

# Update commands here (under construction)
# apt-get update
# apt-get upgrade

# Add forensic features
exec_script ('forensic')

# Add misc. apps
exec_script ('add-misc')

# =============================================================================
# To save time for testing purposes, disable the commands in the section above.
# Do NOT disable the remove-* scripts without also disabling the update script.
# ============================================================================= 

# Add security features
exec_script ('security')

# Add installer
exec_script ('installer')

# Set up control center
exec_script ('ui-config-general')
exec_script ('ui-config-hardware')
exec_script ('ui-config-info')
exec_script ('ui-config-network')
exec_script ('ui-config-printer')
exec_script ('ui-config-software')
exec_script ('ui-config-system')
exec_script ('ui-config-wallpaper')

# Set up user interface
exec_script ('ui-login')
exec_script ('ui-de')
exec_script ('ui-menu')

# Final touches
exec_script ('final') # Must come last
