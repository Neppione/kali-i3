#!/bin/bash



#Update && Upgrade && Install
sudo apt update && sudo apt full-upgrade -y

sudo apt-get install -y gobuster
sudo apt-get install -y seclists
sudo apt-get install -y i3blocks i3 i3-wm
sudo apt-get install -y imagemagick
sudo apt-get install -y rofi
sudo apt-get install -y dmenu


sudo apt remove -y i3lock
sudo apt-get install -y i3lock-color



#Unzip Rockyou
sudo gunzip /usr/share/wordlists/rockyou.txt.gz rockyou.txt



#Fonts
mkdir -p ~/.local/share/fonts/


wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip

unzip Iosevka.zip -d ~/.local/share/fonts/
unzip RobotoMono.zip -d ~/.local/share/fonts/



#Update font cache, force, verbose
fc-cache -fv



#Alacritty
wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.12.0-1/alacritty_0.12.0_amd64_bullseye.deb
sudo dpkg -i alacritty_0.12.0_amd64_bullseye.deb
sudo apt install -f



#Rofi Theme
cp .config/rofi/nord.rasi /usr/share/rofi/themes/nord.rasi



#Directories
mkdir -p ~/.config/i3
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty



#Copy Files
cp .config/i3/config ~/.config/i3/config
cp .config/i3/i3blocks.conf ~/.config/i3/i3blocks.conf
cp .config/rofi/rofi.conf ~/.config/rofi/rofi.conf
cp .config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml















