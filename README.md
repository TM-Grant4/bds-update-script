# BDS Update Script

**This script will help you update your MCB BDS (Minecraft Bedrock Dedicated Server) in the matter of seconds, while keeping your files safe!** 

#
## Disclaimers
1. **Only works on linux machines**
2. **MUST have wget & unzip installed**
- You can install them with the following command: 
```sh
apt update && apt install wget unzip pup
```
3. **Please be in the outside directory of your server.**
- This would mean be outside the folder your server is in, so if your server folder is called "server" then make sure you can see that directory in your terminal when you type "dir"
- This is what that would look like:
```
$ dir
server
```
## How to use.
1. Download the file.
2. Move the file to the folder explained in disclaimer #3.
3. Make the file executable.
- This can be done with the following command:
```sh
chmod +x script.sh
```
4. Run the script.
 - The `<type>` is the desired server typr for your MC BDS server download.
 - Then you can run the script by doing the following command:
```sh
./script.sh <type>
```

## Types. 
---
1. Windows: `win`
2. Ubuntu: `ubuntu`
3. Windows Preview: `win_preview`
4. Ubuntu Preview: `ubuntu_preview`