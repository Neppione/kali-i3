#!/bin/bash



#Update && Upgrade && Install
sudo apt update && sudo apt full-upgrade -y

sudo apt-get install -y gobuster
sudo apt-get install -y seclists
sudo apt-get install -y i3blocks i3 i3-wm
sudo apt-get install -y imagemagick
sudo apt-get install -y rofi
sudo apt-get install -y dmenu
sudo apt-get install -y nvidia-driver nvidia-settings
sudo apt-get install -y mesa-utils
sudo apt-get install -y picom
sudo apt-get install -y feh
sudo apt-get install -y lxapearance
sudo apt-get install -y arc-theme
sudo apt-get install -y Bloodhound



#Install i3lock-color
sudo apt remove -y i3lock
sudo apt-get install -y i3lock-color



#Unzip Rockyou
sudo gunzip /usr/share/wordlists/rockyou.txt.gz rockyou.txt



#Install Nessus
curl --request GET \
  --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.7.4-debian10_amd64.deb' \
  --output 'Nessus-10.7.4-debian10_amd64.deb'
sudo dpkg -i Nessus-10.7.4-debian10_amd64.deb
sudo /bin/systemctl start nessusd.service


#Install Sublime-Text & Repository
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text



#Install Obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.5/obsidian-1.6.5-amd64.deb
sudo dpkg -i obsidian-1.6.5-amd64.deb



#Install VS-Code
wget -qO- https://go.microsoft.com/fwlink/?LinkID=760868 > vscode.deb
sudo dpkg -i vscode.deb



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





