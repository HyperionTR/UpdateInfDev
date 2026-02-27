# UpdateInfDev
An Unofficial Bash script for updating the Minecraft InfDev+ mod by the Legacy+ team using the terminal on Linux,

The script needs to be modified by pasting the location of your MultiMC's Infdev+ Instance folder as the value for the variable `INSTANCE_DIR`.

# How does it works.

The script uses the fact that the `.jar` files that MultiMC uses to overwrite the origal Minecraft's jar, are stored inside the route `instances/[Instance_name]/jarmods`. There, it's the `InfdevPlus-Client.jar `labeled as "InfDev+ Client" on the setting menu of MultiMC.

By replacing this file you can update the game via a script without having to follow the official update process.

# Update process

First the script created a one-time backup for your original .jar file for that InfDev+ instance.

Then, the script takes the official google drive link as a direct download link and saved the downloaded file in a temp folder.

On a succesfull download, the script created a backup of the current game version and copies the newly downloaded version onto the `jarmods` folder.

# Notes

The script allows up to 5 (configurable via editing the number inside the script)  backups.

Each backup is created by date and time of download, rather than game version. This is because i couldn't find any version string inside the downloaded jar.

Also the script is in spanish bc i speak spanish.

--- 

Link used  as a download for the script: `https://drive.google.com/uc?export=download&id=1JRmzcxxDojXMr52W9u5uBfi1pwN80s6O`
