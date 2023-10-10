#!/bin/bash

#
# Variables
#

commands=("alias backup='/backup/backup.sh'" "alias restore='/backup/restore.sh'")

#
# Functions
#

# Add log entry to logs file
function log_entry() {
	echo "$(date +"[%Y/%m/%d %H:%M:%S]"): (init.sh) $1" >> /backup/logs.txt
}

# Move dir to /backup
function move_dir() {
	mv $(pwd) /backup
	log_entry "Moving current directory to /backup"
}

# Add alias to .bashrc
function add_alias() {
	for command in "${commands[@]}"; do
		if grep -Fxq "$command" ~/.bashrc; then
			echo "Alias exists. Skipping..."
			log_entry "$command already exists in .bashrc"
		else
			echo "$command" >> ~/.bashrc
			echo "Alias copied to .bashrc"
			log_entry "Adding $command in .bashrc"
		fi
	done
}

# Add cron entry crontab
function add_crontab() {
	if crontab -l | grep -q "/backup.sh"; then
 		echo "Cron entry exists. Skipping..."
 		log_entry "Cron entry already exists"
	else
		(crontab -l ; echo "50 20 * * * /backup/backup.sh /sourceFolder") | crontab -
		echo "Cron entry added to crontab"
		log_entry "Cron entry added to crontab"
	fi
}

# Inform user
function inform_user() {
	printf "\nYOU'll NEED TO RELOAD THE .bashrc TO USE THE COMMANDS backup AND restore\n"
	echo "IN CRONTAB, YOU MUST CHANGE THE FOLDER THAT YOU WANT TO BACK UP AUTOMATICALLY"
	echo "For more info, check README"
	log_entry "init.sh script executed successfully"
}

#
# Execute
#

log_entry "Executing init.sh script"

move_dir
add_alias
add_crontab
inform_user
