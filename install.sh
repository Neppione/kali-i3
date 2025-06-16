#!/bin/bash

set -e

echo "=== Starte dein vollständiges Master-Deployment (Level 8) ==="

# OPTIONAL: i3lock-color Kompilierung
WITH_I3LOCK_COLOR=false

for arg in "$@"; do
  case "$arg" in
    --with-i3lock-color)
      WITH_I3LOCK_COLOR=true
      ;;
  esac
done

# Paket-Installationsfunktion
install_package() {
  if ! dpkg -s "$1" &> /dev/null; then
    echo "Installiere $1..."
    sudo apt install -y "$1"
  else
    echo "$1 ist bereits installiert."
  fi
}

# System aktualisieren
sudo apt update && sudo apt full-upgrade -y

# Basispakete
BASE_PACKAGES=(
  i3blocks i3 i3-wm imagemagick rofi dmenu feh lxappearance arc-theme i3lock
  cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev
  python3 curl wget unzip fonts-font-awesome jq git
)

for pkg in "${BASE_PACKAGES[@]}"; do
  install_package "$pkg"
done

# Rockyou entpacken
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
  sudo gunzip -kf /usr/share/wordlists/rockyou.txt.gz
fi

# Nerd Fonts installieren
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

download_font() {
  local url="$1"
  local file=$(basename "$url")
  if [ ! -f "$file" ]; then
    wget "$url"
    unzip -o "$file"
  else
    echo "$file bereits vorhanden."
  fi
}

download_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip
download_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip
download_font https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

fc-cache --force --verbose

# Konfigurationsverzeichnisse anlegen
mkdir -p ~/.config/{i3,rofi,alacritty/alacritty/themes,i3lock,wallpaper} ~/scripts

# Lokale Configs kopieren
for dir in i3 rofi alacritty i3lock wallpaper; do
  if [ -d ".config/$dir" ]; then
    cp -r .config/$dir/* ~/.config/$dir/ 2>/dev/null || true
  fi
done

# Rofi Nord Theme kopieren (falls vorhanden)
if [ -f ".config/rofi/nord.rasi" ]; then
  sudo cp .config/rofi/nord.rasi /usr/share/rofi/themes/nord.rasi
fi

# GNOME Screensaver deaktivieren (optional)
gsettings set org.gnome.desktop.session idle-delay 0 || true

# Rust installieren
if ! command -v rustup &> /dev/null; then
  echo "Installiere rustup..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source "$HOME/.cargo/env"
fi

source "$HOME/.cargo/env"
rustup update stable
rustup default stable

# Alacritty automatisch aktuell via GitHub API holen
cd /tmp

if ! command -v jq &> /dev/null; then
  sudo apt install -y jq
fi

LATEST_VERSION=$(curl -s https://api.github.com/repos/alacritty/alacritty/releases/latest | jq -r '.tag_name')
DIR_NAME="alacritty-${LATEST_VERSION#v}"

echo "Baue Alacritty Version: $LATEST_VERSION"

if [ ! -d "$DIR_NAME" ]; then
  wget -O alacritty.tar.gz "https://github.com/alacritty/alacritty/archive/refs/tags/${LATEST_VERSION}.tar.gz"
  tar -xzf alacritty.tar.gz
fi

cd "$DIR_NAME"
cargo build --release

INSTALL_DIR="$HOME/.config/alacritty"
mkdir -p "${INSTALL_DIR}/bin"
cp target/release/alacritty "${INSTALL_DIR}/bin/"

if ! grep -q 'export PATH="$HOME/.config/alacritty/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/.config/alacritty/bin:$PATH"' >> ~/.bashrc
  export PATH="$HOME/.config/alacritty/bin:$PATH"
fi

# Alacritty Nord Theme schreiben
cat > ~/.config/alacritty/alacritty.toml << 'EOF'
[colors.primary]
background = "#2E3440"
foreground = "#D8DEE9"

[colors.cursor]
text = "#2E3440"
cursor = "#D8DEE9"

[colors.normal]
black   = "#3B4252"
red     = "#BF616A"
green   = "#A3BE8C"
yellow  = "#EBCB8B"
blue    = "#81A1C1"
magenta = "#B48EAD"
cyan    = "#88C0D0"
white   = "#E5E9F0"

[colors.bright]
black   = "#4C566A"
red     = "#BF616A"
green   = "#A3BE8C"
yellow  = "#EBCB8B"
blue    = "#81A1C1"
magenta = "#B48EAD"
cyan    = "#8FBCBB"
white   = "#ECEFF4"

[font]
normal = { family = "FiraCode Nerd Font", style = "Regular" }
size = 12.0
EOF

# Bash Prompt setzen
if ! grep -q "CUSTOM PROMPT START" ~/.bashrc; then
    cat >> ~/.bashrc << 'EOF'

# CUSTOM PROMPT START
export PS1="\[\e[38;5;114m\]┌─[\[\e[38;5;250m\]\u\[\e[38;5;114m\]@\[\e[38;5;110m\]\h\[\e[38;5;114m\]]─[\[\e[38;5;250m\]\w\[\e[38;5;114m\]]\n\[\e[38;5;114m\]└──╼ \$ \[\e[0m\]"
# CUSTOM PROMPT END
EOF
fi

# tmux Fix für Bashrc-Laden
if ! grep -q 'if \[ -f ~/.bashrc \]; then . ~/.bashrc; fi' ~/.bash_profile 2>/dev/null; then
    echo 'if [ -f ~/.bashrc ]; then . ~/.bashrc; fi' >> ~/.bash_profile
fi

# Picom-ibhagwan immer aus Source bauen
echo "Baue picom-ibhagwan aus Source..."

sudo apt install -y meson ninja-build libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev \
libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev \
libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev \
libevdev-dev uthash-dev libev-dev libepoxy-dev libx11-xcb-dev libx11-dev libxdg-basedir-dev

cd /tmp
if [ ! -d picom ]; then
  git clone https://github.com/ibhagwan/picom.git
fi
cd picom
git pull
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

echo "✅ picom-ibhagwan erfolgreich installiert."

# Optional i3lock-color
if [ "$WITH_I3LOCK_COLOR" = true ]; then
  echo "Installiere i3lock-color aus Source..."

  sudo apt install -y autoconf automake libpam0g-dev libcairo2-dev libxcb-composite0-dev libev-dev \
  libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev make gcc

  cd /tmp
  if [ ! -d i3lock-color ]; then
    git clone https://github.com/Raymo111/i3lock-color.git
  fi

  cd i3lock-color
  ./install-i3lock-color.sh

  echo "✅ i3lock-color erfolgreich installiert."
else
  echo "Standardmäßig wird nur i3lock installiert."
fi

echo "=== ✅ Fertig: Dein vollständiges unkaputtbares Level 8 System ist installiert ==="
echo "Bitte Terminal neu starten oder 'source ~/.bashrc' ausführen."
