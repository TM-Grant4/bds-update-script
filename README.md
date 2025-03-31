# BDS Update Script

**This script will help you update your MCB BDS (Minecraft Bedrock Dedicated Server) in the matter of seconds, while keeping your files safe!** 

#
## Disclaimers
1. **only works on linux machines**
2. **MUST have wget & unzip installed**
- You can install them with the following command: 
```sh
apt update && apt install wget unzip
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
 - The `<URL>` is the newest URL for the MC BDS server download. You can get this by searching "mc bds" in any browser and going the official Minecraft website and copy the link for the linux server.
 - Then you can run the script by doing the following command:
```sh
./script.sh <URL>
```
