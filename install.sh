#!/bin/bash

set -e

#Fonts
mkdir -p ~/.local/share/fonts/


wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip

unzip Iosevka.zip -d ~/.local/share/fonts/
unzip RobotoMono.zip -d ~/.local/share/fonts/



#Update font cache, force, verbose
fc-cache --force --verbose

#Directories
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/alacritty/themes
mkdir -p ~/vpn/{htb,thm,vulnlab}
mkdir -p ~/boxes/{htb,thm,vulnlab}
mkdir -p ~/tools


cp .config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

#Unzip Rockyou
sudo gunzip /usr/share/wordlists/rockyou.txt.gz rockyou.txt

#Install Software
sudo apt install seclists -y
sudo apt install chisel -y
sudo apt install alacritty -y

echo "=== Alacritty Install Script für Debian ==="

#Abhängigkeiten installieren

echo "Installiere benötigte System-Pakete..."
sudo apt update
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 curl wget

#Rust via rustup installieren (immer aktuell)

if ! command -v rustup &> /dev/null; then
    echo "Installiere rustup..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
else
    echo "rustup ist bereits installiert, update auf neueste stable Version..."
    rustup update stable
fi

#Sicherstellen, dass wir die neueste Rust-Version nutzen

source $HOME/.cargo/env
rustup default stable

echo "Aktuelle Rust-Version: $(rustc --version)"

#Alacritty Source Code holen

cd /tmp
ALACRITTY_VERSION="v0.15.1"
echo "Lade Alacritty ${ALACRITTY_VERSION} herunter..."
wget https://github.com/alacritty/alacritty/archive/refs/tags/${ALACRITTY_VERSION}.tar.gz
tar -xzf ${ALACRITTY_VERSION}.tar.gz
cd alacritty-*

#Kompilieren

echo "Baue Alacritty..."
cargo build --release

#Lokale Installation nach ~/.config/alacritty/

INSTALL_DIR="$HOME/.config/alacritty"
mkdir -p "${INSTALL_DIR}/bin"
cp target/release/alacritty "${INSTALL_DIR}/bin/"

#(Optional) Symbolischen Link setzen, damit es im PATH ist:

if [[ ":$PATH:" != *":$HOME/.config/alacritty/bin:"* ]]; then
    echo "Füge ~/.config/alacritty/bin zum PATH hinzu"
    echo 'export PATH="$HOME/.config/alacritty/bin:$PATH"' >> "$HOME/.bashrc"
    export PATH="$HOME/.config/alacritty/bin:$PATH"
fi
sudo apt install alacritty -y

















