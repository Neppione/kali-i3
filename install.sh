#!/bin/bash


# Full update and upgrade of Kali Linux
sudo apt update && sudo apt full-upgrade -y


# Install tools and i3 window manager
sudo apt-get install -y gobuster
sudo apt-get install -y Seclists
sudo apt-get install -y xorg lightdm lightdm-gtk-greeter i3 i3-wm i3lock i3status i3blocks dmenu
sudo apt-get install -y flameshot arc-theme feh python3-pip rofi

# Load Fonts
mkdir -p ~/.local/share/fonts/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip

unzip Iosevka.zip -d ~/.local/share/fonts/
unzip RobotoMono.zip -d ~/.local/share/fonts/


# Update font cache
fc-cache -fv


# Install alacritty via package manager
wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.10.0-rc4-1/alacritty_0.10.0-rc4-1_amd64_bullseye.deb
sudo dpkg -i alacritty_0.10.0-rc4-1_amd64_bullseye.deb
sudo apt install -f


# Install pywal
pip3 install pywal


# Create directorys for the configs
mkdir -p ~/.config/i3
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/scripts

cp .config/i3/config ~/.config/i3/config
cp .config/i3/i3blocks.conf ~/.config/i3/i3blocks.conf
cp .config/rofi/squared-nord.rasi ~/.config/rofi/squared-nord.rasi
cp .config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
cp -r .wallpaper/wallpaper.jpg ~/home/neppi/Pictures/wallpaper.jpg


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
