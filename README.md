# My conky template
Code base is from <a href="https://www.deviantart.com/didi79/art/conky-config-127651851">`didi79`</a>

![Imgur](https://i.imgur.com/fiCotn2.png)

## kern.log conky
Added second conky config file `conkyrc2` which displays last 10 messages from kern.log file.  
2020-03-22 Added COVID-19 statistics by country.
![Imgur](https://i.imgur.com/Q5YNL4j.png)

## Google Keep conky
Added third conky config file `conkyrc3` which displays note from your Google Keep account.

![Imgur](https://i.imgur.com/2VBGWjx.png)

## Dependencies
* python3
* conky
* gcal (terminal calendar)
* gkeep (python3 module for Google Keep)

## Install 

1. Install dependencies.
2. Create `conky`  directory.
```
mkdir ~/.config/conky
```
3. Move repository files to `conky` directory.
4. Modify `conkyrc*` files to match your system parameters (cpu cores, drive mount points, network adapter name, monitor configuration).
5. Make scripts executable.
```
chmod +x ~/.config/conky/*.sh
```
6. Create `auth.txt` with your Google account information:
```
<username> <password>
```
If you're using 2FA you will need to create application password. Go to https://myaccount.google.com/security select application passwords then generate new password.
Enter application password in `auth.txt`
```
<username> <application_password>
```
7. Check if you can read your note from terminal
```
gkeep --auth </path/to/auth.txt> search-notes --not-deleted "<your note name>"
```
If all is well update `conkyrc3` with your values.

8. Add `conky_startup.sh` to application autostart. On xfce desktop go to
Settings > Session and Startup > Application Autostart > Add

9. You can run `conky_startup.sh` to start conky.
