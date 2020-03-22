This is my conky template.
Code base is from <a href="https://www.deviantart.com/didi79/art/conky-config-127651851"><b>didi79</b></a>

## Dependencies
<ul>
  <li>python3</li>
  <li>conky</li>
  <li>gcal (terminal calendar)</li>
</ul>

Tested on Linux Mint 19.3 with conky version 1.10.8. Screenshots are from 27" 1440p monitor.

## kern.log conky
Added second conky config file <b>conkyrc2</b> which displays last 3 messages from kern.log file.
<i>2020-03-22</i> Added COVID-19 statistics.

## Installation
1. Install dependencies.
2. Create <b>conky</b> folder in your home directory.
```
mkdir ~/.config/conky
```
3. Move files to <b>conky</b>.
4. Modify <b>conkyrc</b> and <b>conkyrc2</b> to match your system parameters (cpu cores, drive mount points, network adapter name, monitor configuration).
5. Make <b>conky_startup.sh</b> executable.
```
chmod +x ~/.config/conky/conky_startup.sh
```
6. Add <b>conky_startup.sh</b> to application autostart. On xfce desktop go to
Settings > Session and Startup > Application Autostart > Add
7. You can run <b>conky_startup.sh</b> to start conky.

## Note
If you are using gnome desktop, you will probably need to change in <b>conkyrc</b> and <b>conkyrc2</b>
```
own_window_type override
```
to
```
own_window_type desktop
```

![both_conky](https://raw.githubusercontent.com/f5AFfMhv/conky/master/screenshots/conky200322.png)