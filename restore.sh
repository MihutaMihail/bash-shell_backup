#!/bin/bash

#
# Variables
#

name_archive=$1
number=1

#
# Remote Server Details
#

remote_ip="192.168.64.5"
remote_user="root"
remote_directory="/serverBackup"

#
# Functions
#

# Add log entry to logs file
function log_entry() {
	echo "$(date +"[%Y/%m/%d %H:%M:%S]"): (backup.sh) $1" >> /backup/logs.txt
}

# Show the list of backups
function find_backups() {
  ssh ${remote_user}@${remote_ip} "bash -s" << EOF
    file_count=\$(find ${remote_directory} -name '*.tar.gz' | wc -l)

    if [ \$file_count -ne 0 ]; then
      number=1
      for archive in "${remote_directory}"/*; do
        if [ -f "\$archive" ]; then
          archive_name=\$(basename "\$archive")
          echo "\$number. \$archive_name"
          ((number=number+1))
        fi
      done
      printf "\nTYPE THE ARCHIVE NAME THAT YOU WANT TO RESTORE\n"
    else
      echo "YOU MUST CREATE A BACKUP BEFORE SEEING THE LIST OF BACKUPS"
    fi
EOF
}

# Get the chosen backup
function get_backup() {
  if ssh ${remote_user}@${remote_ip} "test -f '${remote_directory}/${name_archive}'"; then
    scp ${remote_user}@${remote_ip}:"${remote_directory}/${name_archive}" . > /dev/null
    echo "Backup was copied to current directory: $(pwd)"
  else
    echo "THE BACKUP DOESN'T EXIST"
  fi
}

#
# Execute
# 

log_entry "Executing restore.sh script"

if [ -z "$name_archive" ]; then 
	find_backups
	log_entry "List of backups"
else
	get_backup
	log_entry "Restore backup"
fi
