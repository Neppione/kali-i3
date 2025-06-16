#!/bin/bash



#Update && Upgrade && Install
sudo apt update && sudo apt full-upgrade -y


sudo apt-get install -y i3blocks i3 i3-wm
sudo apt-get install -y imagemagick
sudo apt-get install -y rofi
sudo apt-get install -y dmenu
sudo apt-get install -y picom
sudo apt-get install -y feh
sudo apt-get install -y lxapearance
sudo apt-get install -y arc-theme




#Install i3lock-color
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
#find ~/.local/share/fonts -name "README.md" -type f -delete
fc-cache --force --verbose



#Alacritty
wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.12.0-1/alacritty_0.12.0_amd64_bullseye.deb
sudo dpkg -i alacritty_0.12.0_amd64_bullseye.deb
sudo apt install -f



#Rofi Theme
sudo cp .config/rofi/nord.rasi /usr/share/rofi/themes/nord.rasi



#Directories
mkdir -p ~/.config/i3
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/alacritty/themes
mkdir -p ~/.config/i3lock
mkdir -p ~/.config/wallpaper
mkdir -p ~/scripts


#Copy Files
cp .config/i3/config ~/.config/i3/config
cp .config/i3/i3blocks.conf ~/.config/i3/i3blocks.conf
cp .config/rofi/rofi.conf ~/.config/rofi/rofi.conf
cp .config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
cp .config/i3lock/i3lock.conf ~/.config/i3lock/i3lock.conf
cp .config/wallpaper/wp* ~/.config/wallpaper/
cp .config/rofi/config.rasi ~/.config/rofi/config.rasi



git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes



#Disable Screensaver
gsettings set org.gnome.desktop.session idle-delay 0



#New alacritty with TOML file
sudo apt update
sudo apt upgrade -y


#Install ldapdomaindump
cd ~/scripts
git clone https://github.com/dirkjanm/ldapdomaindump.git
cd ldapdomaindump
pip3 install -r requirements.txt
























