# My conky template
Code base is from <a href="https://www.deviantart.com/didi79/art/conky-config-127651851">`didi79`</a>

![Imgur](https://i.imgur.com/JeSErwc.png)

## sysinfo_conkyrc
Conky configuration for displaying time, calendar and main system information. This conkyrc uses `get_publicIP.py` script to determine your public IP address from https://ipinfo.io service.
## kernlog_conkyrc
Conky configuration which displays last 10 messages from `kern.log` file.
## covid_conkyrc
Conky configuration for displaying COVID-19 single country statistics. Stats is collected by `corona.sh` from https://corona-stats.online
## aliases_conkyrc
Conky configuration which displays user aliases from `.bashrc`. To exclude alias from this list add space before `alias` keyword in .bashrc file.
## meteo_conkyrc
Conky configuration which uses `meteo.sh` script to display hourly weather forecast from https://api.meteo.lt service.
## gkeep_conkyrc [DEPRECATED]
Conky configuration which displays note from your Google Keep account.  
![Imgur](https://i.imgur.com/2VBGWjx.png)

# Dependencies
* `conky`
* `python3`
* `lm-sensors` (utility for reading various sensors)
* `gcal` (terminal calendar)
* `nvidia-smi` (in case you have nvidia card)
* `gkeep` (python3 module for Google Keep)

# Installation
1. Install dependencies.
2. Create `conky`  directory.
```
mkdir ~/.config/conky
```
3. Move repository files to `conky` directory.
4. Modify `conkyrc` files to match your system parameters (drive mount points, network adapter name, monitor configuration, etc.).
5. Make scripts executable.
```
chmod +x ~/.config/conky/*.sh
```
6. Modify `conky_start.sh` for which conky configurations you want to use.
7. Add `conky_start.sh` to autostart applications. On xfce desktop go to  
`Settings > Session and Startup > Application Autostart > Add`
8. You can run `conky_startup.sh` to start conky.

## conky.service
Alternatively you can start conky as systemd service:
1. Create service directory for your user
```
mkdir -p $HOME/.local/share/systemd/user
```
2. Move `conky.service` file to that directory and modify service file with absolute path to `conky_start.sh`
```
ExecStart=/home/<USER>/.config/conky/conky_start.sh
```
3. Enable and start service
```
systemctl --user enable conky.service
systemctl --user start conky.service
```

## Google Keep Configuration [DEPRECATED]
1. Create `auth.txt` with your Google account information:
```
<username> <password>
```
If you're using 2FA you will need to create application password. Go to https://myaccount.google.com/security select application passwords then generate new password.
Enter application password in `auth.txt`
```
<username> <application_password>
```
2. Check if you can read your note from terminal
```
gkeep --auth </path/to/auth.txt> search-notes --not-deleted "<your note name>"
```
If all is well update `gkeep_conkyrc` with your values.