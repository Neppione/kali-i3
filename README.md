# Kali-i3

Hello everyone. Here is my Kali-Linux installation script with various tools and software. 
I was inspired by xct (https://github.com/xct/kali-clean) but made some changes for myself.
I hope you enjoy these setup and pls let me know what you think about it. 

The following tools and software are installed:


- gobuster  	
- seclists
- i3 window manager
- i3blocks
- i3lock-color
- imagemagick
- rofi
- dmenu
- Nvidia-driver
- nvidia-settings
- mesa-utils
- picom
- feh
- lxappearance
- arc-theme
- neo4j
- bloodhound
- mitm6
- nessus
- vscode
- obsidian
- sublime-text
- alacritty
- ldapdomaindump
- unzip rockyou.txt (on default path: /usr/share/wordlists/)



!!!Note: If you have an AMD graphics card, please commit out the following:

- Nvidia-driver
- Nvidia-settings



You can also uncomment mesa-utils if you don't need it.
mesa-utils is a utility for the Mesa 3D graphics library.

---


# Installation

Clone the repo and run the install.sh script without sudo (normal user).
On the installation you will be asked if you want to replace the README.md from the "Nerd Fonts". You can select (A)ll.
After that, reboot and on the login screen select in the right bottom corner "i3".
You need to select your user first. After that you have the settings button in the corner.
Now you can start.

---


# Tools and how to use it

## i3

i3 is a tiling window manager designed for X11. 
You can open a terminal with the Win + Enter keybind.

Here is a quick overview of useful keybinds:

| Keybinding               | Description                                       |
| ------------------------ | ------------------------------------------------- |
| `Mod + Enter`            | Open terminal.                                    |
| `Mod + ←`                | Focus left.                                       |
| `Mod + →`                | Focus right.                                      |
| `Mod + ↑`                | Focus up.                                         |
| `Mod + ↓`                | Focus down.                                       |
| `Mod + Shift + ←`        | Move the window to the left side.                 |
| `Mod + Shift + →`        | Move the window to the right side.                |
| `Mod + Shift + ↑`        | Move the window up.                               |
| `Mod + Shift + ↓`        | Move the window down.                             |
| `Mod + f`                | Toggle the focused window to full-screen.         |
| `Mod + v`                | The next window will be placed vertically.        |
| `Mod + h`                | The next window will be placed horizontally.      |
| `Mod + s`                | Enables the stacked window layout.                |
| `Mod + w`                | Enables the tabbed window layout.                 |
| `Mod + Shift + Space`    | Enables the floating window (for focused window). |
| `Mod + Left-mouse-click` | Drag the entire window using the mouse.           |
| `Mod + 0-9`              | Switch to another workspace.                      |
| `Mod + Shift + 0-9`      | Move the window to another workspace.             |
| `Mod + d`                | Open the application launcher (D menu).           |
| `Mod + Shift + q`        | Kills the focused window.                         |
| `Mod + Shift + c`        | Reloads the I3 config file.                       |
| `Mod + Shift + r`        | Restart the I3 WM.                                |
| `Mod + Shift + e`        | Exit I3 WM.                                       |


The config file is in ~/.config/i3. You can setup things like 

- i3-gaps (the gaps between the individual windows)
- Wallpaper
- i3bar font
- and the keybinds

---


# Alacritty

It is the newest version (0.13.2) 
Alacritty is a terminal emulator and full customizable.
Also installed are the alacritty themes. 

- https://github.com/alacritty/alacritty-theme
 
You only need to edit the alacritty config located in ~.config/alacritty.
Change the first line from 

	import = ["~/.config/alacritty/themes/themes/[YOUR-THEME]"]

in whatever you want. 
See the various themes on the github page.
You can also change the: 

- Font size 
- Window opacity
- and various keybinds

---


# rofi 

Rofi is a lightweight application launcher and window switcher for X11.
It is an customizable alternative to "dmenu". Originally created as a clone of "dmenu", rofi has grown to include a variety of features 
and can be used for a wide range of tasks.

The config file is located on ~/.config/rofi 
and the themes located on     /usr/share/rofi/themes

pre-installed is the theme nord.rasi but you can change these to whatever you want.
Check out the github page for more themes

- https://github.com/newmanls/rofi-themes-collection

---





































