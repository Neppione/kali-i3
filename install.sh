#!/bin/bash


#Update && Upgrade && Install


#sudo apt update && sudo apt full-upgrade -y

sudo apt-get install -y gobuster
sudo apt-get install -y i3blocks i3 i3-wm
sudo apt-get install -y imagemagick
sudo apt-get install -y

sudo apt remove i3lock
sudo apt-get install -y i3lock-color




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


























