## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Commands](#commands)
- [About](#about)
- [Problems](#problems)

## Introduction

These scripts allow for backing any directory to a remote server. You choose the directory, it performs the backup, and you can retrieve that particular backup anytime you want.

## Installation

Execute the **init.sh** script like so : ```$./init.sh``` <br>
**WARNING : IF THE CRONTAB FILE DOESN'T EXIST, YOU MUST CREATE IT WITH** ```$crontab -e``` <br>
you can select any editor**<br>

This will move the current directory to **/backup** and add the two commands as alias in .bashrc <br>
It's important that you don't move this directory to make sure that the commands work <br> <br>
*if needed you can type $chmod +x init.sh so that the init.sh can be executed*

## Commands

### ```$backup``` 
This command will perform a backup on the current active directory <br>
If you want to know which directory is that type : ```$pwd``` <br>
The backup will be in the form of **tar.gz** <br>
**Usage** :  ```$backup```

### ```$backup ...``` 
Same thing the previous command, except you can choose which particular directory to back up. <br>
**Usage** :  ```$backup /nameDirectory```

### ```$restore``` 
This command will display all available archives on the remote server that you can retrieve <br>
**Usage** :  ```$restore```

### ```$restore ...``` 
This command will retrieve your wanted archive <br>
**Usage** :  ```$restore nameArchvie```

## About
• There is a **logs.txt** file where you can see which commands the user has executed 

#### • .bashrc
You will need to manually reload the **.bashrc** once you have executed the init.sh script.
To do so, you will need to execute one command : ```$source .bashrc```

#### • crontab
This is the default cron entry : <br>
```0 18 * * * /backup/backup.sh /sourceFolder```

• 0 represents the minute <br>
• 18 represents the hour <br>
• * * * signifies that it will be executed every day of the week / month / year <br>
• next is the script location **WARNING : DON'T CHANGE THIS** <br>
• last is your desired folder to be backed up every day

## Problems
• The automatic back up (crontab) does correctly execute if done on the local machine, however, when done on the remote server, doesn't work. Technically it does, because the coded is correct, but because you will need to type a passcode since we want to have a secure transfer. I'm assuming that because you cannot type this passcode when done automatically, it immediately refuses the transfer. I can make it function, but I thought that removing the passcode and removing a layer of security is not worth it.

• There is also an extra DOC that was needed for the project which does explains some parts of the code.
