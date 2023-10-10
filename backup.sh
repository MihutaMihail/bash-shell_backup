#!/bin/bash

#
# Variables
#

send_backup=0
current_dir=$(pwd)
chosen_dir=$1
archive_name="backup_$(date +"%Y-%m-%d_%H%M%S").tar.gz"
temp_dir=$(mktemp -d)

#
# Remote Server Details
#

remote_ip="192.168.64.5"
remote_user="root"
remote_directory="/serverBackup"

# SSH Agent
# private_key=~/.ssh/id_rsa

# eval $(ssh-agent)
# ssh-add $private_key

#
# Functions
#

# Add log entry to logs file
function log_entry() {
	echo "$(date +"[%Y/%m/%d %H:%M:%S]"): (backup.sh) $1" >> /backup/logs.txt	
}

# Backup directory
function backup_dir() {
	dir=$1
	file_count=$(find $dir -type f | wc -l)

	if [ $file_count -ne 0 ]; then
		cp -R "$dir"/* "$temp_dir"
		send_backup=1
		log_entry "Backup of directory : $dir"
	else
		echo "NO FILES DETECTED IN $dir"
		log_entry "No files detected in $dir"
	fi
}

# Send backup to server
function send_backup_to_server() {
	send=$1

	if [ "$send" -eq 1 ]; then
 		tar -czf "$temp_dir/$archive_name" -C "$temp_dir" .
		scp "$temp_dir/$archive_name" ${remote_user}@${remote_ip}:${remote_directory}/
		# for the ssh agent add scp -i $private key ...

 		rm -rf "$temp_dir"
 		echo "Backup completed"
 		log_entry "BACKUP COMPLETED"
	fi
}

#
# Execute
#

log_entry "Executing backup.sh script"

if [ -z "$chosen_dir" ]; then
	backup_dir $current_dir
else
	if [ -d "$chosen_dir" ]; then
		backup_dir $chosen_dir
	else
		echo "THE DIRECTORY DOESN'T EXIST"
		log_entry "Directory doesn't exist"
	fi
fi

send_backup_to_server $send_backup

# close ssh agent
# ssh-agent -k
