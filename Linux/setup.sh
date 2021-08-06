#!/bin/bash

# Quick setup script for new server

#Make sure the script is run as root

if [ ! #UID -ne 0 ]
then 
	echo "Please run this script with sudo."
	exit
fi

# Creat e a log file that our script wil use to track its progress

log_file=/var/log/setup_script.log

# Log file header

echo "log file for general server setup script." >> $log_file
echo "########################################## >> $log_file
echo "log generated on $(date) >> $log_file
echo "" >> $log_file

# List of necessary packages
packages=(
	'nano'
	'wget'
	'net-tools'
	'python'
	'tripwire'
	'tree'
	'curl'
)

# Ensure all packages are installed

for package in ${packages[@]}
do
	if [ ! $(which $package) ]
	then
	  apt install -y $package
	fi
done

# Print it out and log it

echo "$(date) Installed needed packages: ${packages[@]}" | tee -a $logfile

# Create user sysadmin with no password (password to be created upon login)

useradd sysadmin
chage -d 0 sysadmin

# add the sysadmin user to the 'sudo' group

usermod -aG sudo sysadmin

# Print and log

echo "$(date) Created sys_admin user. Password to be created upon login" | tee -a $log_file

# Remove root's login shell and lock the root account.
usermod -s /sbin/nologin root
usermod -L root

# Print and log
echo "$(date) Disabled root shell. Root user cannot login." | tee -a $log_file

# Change permissions on sensitive files
chmod 600 /etc/shadow
chmod 600 /etc/gshadow
chmod 644 /etc/group
chmod 644 /etc/passwd

# Print and log
echo "$(date) Changed permissions on sensitive /etc files." | tee -a $log_file

# Setup scripts folder
if [ ! -d /home/sysadmin/scripts ]
then
mkdir /home/sysadmin/scripts
chown sysadmin:sysadmin /home/sysadmin/scripts
fi

# Add scripts folder to .bashrc for ryan
echo "" >> /home/sysadmin/.bashrc
echo "PATH=$PATH:/home/sysadmin/scripts" >> /home/ryan/.bashrc
echo "" >> /home/sysadmin/.bashrc


# Print and log
echo "$(date) Added ~/scripts directory to sysadmin's PATH." | tee -a $log_file


Adding a few custom aliases might be nice too!

```bash
# Add custom aliases to /home/sysadmin/.bashrc
echo "#Custom Aliases" >> /home/sysadmin/.bashrc
echo "alias reload='source ~/.bashrc && echo Bash config reloaded'" >> /home/sysadmin/.bashrc
echo "alias lsa='ls -a'" >> /home/sysadmin/.bashrc
echo "alias docs='cd ~/Documents'" >> /home/sysadmin/.bashrc
echo "alias dwn='cd ~/Downloads'" >> /home/sysadmin/.bashrc
echo "alias etc='cd /etc'" >> /home/sysadmin/.bashrc
echo "alias rc='nano ~/.bashrc'" >> /home/sysadmin/.bashrc

# Print and log
echo "$(date) Added custom alias collection to sysadmin's bashrc." | tee -a $log_file

#Print out and log Exit
echo "$(date) Script Finished. Exiting."
echo "$(date) Script Finished. Exiting." >> $log_file

exit

