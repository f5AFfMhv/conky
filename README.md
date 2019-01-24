This is my conky template.
Code base is from didi79:
<i>https://www.deviantart.com/didi79/art/conky-config-127651851</i>

<b>DEPENDENCIES:</b>
<ul>
  <li><s>Python</s></li>
  <li>conky</li>
  <li>gcal</li>
</ul>

Tested on Linux Mint 19 with conky 1.10.8. Screenshots are from 27" 1440p monitor.

<b>INSTALATION:</b>

1. Install conky.
2. Configure conky for autostart.
3. Move .conkyrc to your user home directory.
4. Modify .conkyrc to match your system (cpu cores, drive mount points, network adapter name).
5. <s>Create .conky directory in user home.</s>
6. <s>Move	get_publicIP.py to ~/.conky (make sure script can be executed by your user).</s>

----------------------------------------------
ipinfo.io removed free public IP check feature. Now conky checks public IP from api.ipify.org. 
get_publicIP.py is deprecated.
----------------------------------------------

![conky_full](https://raw.githubusercontent.com/f5AFfMhv/conky/master/conky_full.png)
![just_conky](https://raw.githubusercontent.com/f5AFfMhv/conky/master/just_conky.png)
