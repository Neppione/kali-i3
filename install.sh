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
set -e

echo "=== Alacritty Install Script für Debian ==="

# 1. Abhängigkeiten installieren
echo "Installiere benötigte System-Pakete..."
sudo apt update
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 curl wget

# 2. Rust via rustup installieren (immer aktuell)
if ! command -v rustup &> /dev/null; then
    echo "Installiere rustup..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
else
    echo "rustup ist bereits installiert, update auf neueste stable Version..."
    rustup update stable
fi

# Sicherstellen, dass wir die neueste Rust-Version nutzen
source $HOME/.cargo/env
rustup default stable

echo "Aktuelle Rust-Version: $(rustc --version)"

# 3. Alacritty Source Code holen
cd /tmp
ALACRITTY_VERSION="v0.15.1"
echo "Lade Alacritty ${ALACRITTY_VERSION} herunter..."
wget https://github.com/alacritty/alacritty/archive/refs/tags/${ALACRITTY_VERSION}.tar.gz
tar -xzf ${ALACRITTY_VERSION}.tar.gz
cd alacritty-*

# 4. Kompilieren
echo "Baue Alacritty..."
cargo build --release

# 5. Lokale Installation nach ~/.config/alacritty/
INSTALL_DIR="$HOME/.config/alacritty"
mkdir -p "${INSTALL_DIR}/bin"
cp target/release/alacritty "${INSTALL_DIR}/bin/"

# 6. (Optional) Symbolischen Link setzen, damit es im PATH ist:
if [[ ":$PATH:" != *":$HOME/.config/alacritty/bin:"* ]]; then
    echo "Füge ~/.config/alacritty/bin zum PATH hinzu"
    echo 'export PATH="$HOME/.config/alacritty/bin:$PATH"' >> "$HOME/.bashrc"
    export PATH="$HOME/.config/alacritty/bin:$PATH"
fi

echo "=== Alacritty wurde erfolgreich lokal installiert ==="
"$INSTALL_DIR/bin/alacritty" --version


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


























