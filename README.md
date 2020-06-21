This is my conky template.
Code base is from <a href="https://www.deviantart.com/didi79/art/conky-config-127651851"><b>didi79</b></a>

![both_conky](https://raw.githubusercontent.com/f5AFfMhv/conky/master/screenshots/conky200322.png)

## Dependencies
<ul>
  <li>python3</li>
  <li>conky</li>
  <li>gcal (terminal calendar)</li>
  <li>gkeep (python3 module for Google Keep)</li>
</ul>

Tested on Linux Mint 19.3 with conky version 1.10.8. Screenshots are from 27" 1080p monitor.

## kern.log conky
Added second conky config file <b>conkyrc2</b> which displays last 10 messages from kern.log file.
<br>
<i>2020-03-22</i> Added COVID-19 statistics by country.

## Google Keep conky
Added third conky config file <b>conkyrc3</b> which displays note from your Google Keep account.
<br>

## Installation
1. Install dependencies.
2. Create <b>conky</b>  directory.
```
mkdir ~/.config/conky
```
3. Move repository files to <b>conky</b> directory.
4. Modify <b>conkyrc*</b> files to match your system parameters (cpu cores, drive mount points, network adapter name, monitor configuration).
5. Make scripts executable.
```
chmod +x ~/.config/conky/*.sh
```
6. Create auth.txt with your Google account information:
```
<username> <password>
```
If you're using 2FA you will need to create application password. Go to https://myaccount.google.com/security select application passwords then generate new password.
Enter application password in auth.txt
```
<username> <application_password>
```
7. Check if you can read your note from terminal
```
gkeep --auth </path/to/auth.txt> search-notes --not-deleted "<your note name>"
```
If all is well update <b>conkyrc3</b> with your values.

8. Add <b>conky_startup.sh</b> to application autostart. On xfce desktop go to
Settings > Session and Startup > Application Autostart > Add

9. You can run <b>conky_startup.sh</b> to start conky.

## Note
If you are using gnome desktop, you will probably need to change 
```
own_window_type override
```
to
```
own_window_type desktop
```
in <b>conkyrc*</b>