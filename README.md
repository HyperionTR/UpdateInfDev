# InfDev+ Auto-Updater Script

I made this script to automatically update the InfDev+ mod using a terminal command instead of messing with the MultiMC GUI every time there is a new build.

### Setup
The script needs you to set your instance path. Open the script file and paste the location of your MultiMC Infdev+ Instance folder in the `INSTANCE_DIR` variable.

### How it works
MultiMC handles jar-modding by storing specific files in `instances/[Instance_name]/jarmods`. Inside this folder, you'll find `InfdevPlus-Client.jar` (the file labeled as "InfDev+ Client" in your MultiMC settings).

By replacing this file directly, the script updates the game without following the manual official process.

### Update Process
1. **Initial Backup**: On the first run, the script creates a one-time backup of your original .jar file in a folder called `og_jar_backup`.
2. **Download**: It fetches the latest version from the official Google Drive link and saves it to a temporary location.
3. **Safety Check**: If the download is successful, the script creates a timestamped backup of your current version before overwriting it.
4. **Installation**: The new version is moved to the `jarmods` folder.

### Notes
- The script keeps up to 5 backups (you can change this number in the config section). 
- Backups are sorted by date and time because I couldn't find a reliable version string inside the jar file to use for naming.
- The script messages are in spanish because I first thought of using this only for myself.
- The download can take a few seconds to start. Not because of your internet connection, but because of some strange caveats with Google Drive's dowload link.
- The download link is based of the original InfDev+ file link, but slightly modified with the parameter `export=download` so it can be used inside a script with wget(bash) or irq(ps1).

---

**Download Link used by the script:**
https://drive.google.com/uc?export=download&id=1JRmzcxxDojXMr52W9u5uBfi1pwN80s6O
