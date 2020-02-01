This is my conky template.
Code base is from <a href="https://www.deviantart.com/didi79/art/conky-config-127651851"><b>didi79</b></a>

## Dependencies
<ul>
  <li>python3</li>
  <li>conky</li>
  <li>gcal (terminal calendar)</li>
</ul>

Tested on Linux Mint 19 with conky version 1.10.8. Screenshots are from 27" 1440p monitor.

## kern.log conky
Added second conky config file <b>conkyrc2</b> which displays last 25 messages from kern.log file on the second monitor. See screenshot from 27" 1080p monitor at the bottom.

## Installation
1. Install dependencies.
2. Create <b>.conky</b> folder in your home directory.
```
mkdir ~/.conky
```
3. Move files to <b>.conky</b>.
4. Modify <b>conkyrc</b> and <b>conkyrc2</b> to match your system parameters (cpu cores, drive mount points, network adapter name, monitor configuration).
5. Make <b>conky_startup.sh</b> executable.
```
chmod +x ~/.conky/conky_startup.sh
```
6. Add <b>conky_startup.sh</b> to application autostart. On xfce desktop go to
Settings > Session and Startup > Application Autostart > Add
7. You can run <b>conky_startup.sh</b> to start conky.

![conky_full](https://raw.githubusercontent.com/f5AFfMhv/conky/master/screenshots/just_conky.png)
![just_conky](https://raw.githubusercontent.com/f5AFfMhv/conky/master/screenshots/desk_blue.png)
![log_conky](https://raw.githubusercontent.com/f5AFfMhv/conky/master/screenshots/log_conky.png)