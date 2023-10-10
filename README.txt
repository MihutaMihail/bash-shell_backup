README

### INSTALL ###
For the backup to work you will need to execute the **init.sh** file. You can do so by typing : $./init.sh
WARNING : IF THE CRONTAB FILE DOESN'T EXIST, YOU MUST CREATE IT WITH $crontab -e
(you can select any editor)

This will move the current directory to /backup and add the two commands as alias in .bashrc
It's important that you don't move this directory to make sure that the commands work
(if needed you can type $chmod +x init.sh so that the init.sh can be executed)

### COMMANDS ###

### backup / backup ...
This command will backup every single file from a directory. The directory can be either the current active directory,
(use $pwd to check the directory that you're in), or it can be a directory that you can choose.
Something like $backup /filesToBackup
Once you have chosen you directory and typed the command $backup, it will compress every file into a .tar.gz archive.

### restore / restore ...
The command $restore allows you to see all current backups. If you wish to restore a specific backup, you can use the command
$restore nameArchive. This will download the archive to your directory where you can extract it with $tar -xf nameArchive.

### HELP ###

### .bashrc ###
You will need to manually reload the .bashrc once you have executed the init.sh script.
To do so, you will need to follow these commands :
1. $cd
2. $source .bashrc
You now should be able to use the commands backup and restore freely

### crontab ###
This is the default cron entry :
0 18 * * * /backup/backup.sh /sourceFolder

0 represents the minute
18 represents the hour
* * * signifies that it will be executed every day of the week / month / year
next is the script location (WARNING : DON'T CHANGE THIS)
last is your desired folder to be backed up every day
