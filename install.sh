#!/usr/bin/env bash

# ==============================================================================
#  HYPRLAND NORD MINIMALIST & SHARP DOTFILES AUTO-INSTALLER
#  Arch Linux Automated Setup Script
# ==============================================================================

set -e

# ANSI Color Codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${CYAN}${BOLD}"
echo "  _   _                  _                 _   _               _ "
echo " | | | |_   _ _ __  _ __| | __ _ _ __   __| | | \ | | ___  _ __ __| |"
echo " | |_| | | | | '_ \| '__| |/ _\` | '_ \ / _\` | |  \| |/ _ \| '__/ _\` |"
echo " |  _  | |_| | |_) | |  | | (_| | | | | (_| | | |\  | (_) | | | (_| |"
echo " |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_| |_| \_|\___/|_|  \__,_|"
echo "        |___/|_|                                                     "
echo -e "${NC}"
echo -e "${GREEN}==> Starting automated setup for Arch Linux...${NC}\n"

# 1. Update Pacman Keyring & Fastest Global CDN Mirrors
echo -e "${YELLOW}==> [1/7] Configuring pacman mirrors...${NC}"
cat << 'EOF' | sudo tee /etc/pacman.d/mirrorlist
Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch
Server = https://mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch
EOF

sudo pacman -Sy --noconfirm archlinux-keyring

# 2. Install Yay (AUR Helper) if not installed
echo -e "${YELLOW}==> [2/7] Checking AUR Helper (yay)...${NC}"
if ! command -v yay &> /dev/null; then
    echo -e "${CYAN}Installing yay...${NC}"
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    (cd /tmp/yay-bin && makepkg -si --noconfirm)
    rm -rf /tmp/yay-bin
fi

# 3. Install Official Pacman Packages
echo -e "${YELLOW}==> [3/7] Installing essential official packages...${NC}"
PACKAGES=(
    # Core Window Manager & Audio/Video
    hyprland
    waybar
    rofi-wayland
    kitty
    swaybg
    hyprlock
    hypridle
    hyprpolkitagent
    libnotify
    psmisc
    qt6ct
    ttf-jetbrains-mono-nerd
    iwd
    networkmanager
    swaync
    pipewire
    pipewire-alsa
    pipewire-pulse
    pipewire-jack
    wireplumber
    pamixer
    pavucontrol
    brightnessctl
    playerctl
    wl-clipboard
    cliphist
    grim
    slurp
    mpv
    imv
    btop
    fastfetch
    nano

    # Keyring & Security for Apps (VS Code, Chrome, etc)
    gnome-keyring
    libsecret
    seahorse
    gcr
    gcr-4

    # File Manager & KDE tools
    dolphin
    kde-cli-tools
    kdesu
    kio-admin
    ark
    unzip
    p7zip
    unrar
    ffmpegthumbnailer
    kdegraphics-thumbnailers
    xdg-user-dirs

    # Drivers, Networking & Bluetooth
    ntfs-3g
    dosfstools
    exfatprogs
    bluez
    bluez-utils
    bluez-obex
    impala
    power-profiles-daemon
    ufw

    # Portals & Theming
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    qt5-wayland
    qt6-wayland
    ttf-cascadia-code-nerd inter-font
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    papirus-icon-theme
    nwg-look
)

sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

# 4. Install AUR Packages
echo -e "${YELLOW}==> [4/7] Installing AUR packages (bluetuith, google-chrome, visual-studio-code)...${NC}"
yay -S --needed --noconfirm bluetuith-bin google-chrome visual-studio-code-bin

# 5. Deploy Dotfiles (.config & Wallpapers)
echo -e "${YELLOW}==> [5/7] Deploying configuration files...${NC}"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Pictures/Wallpapers"
mkdir -p "$HOME/Pictures/Screenshots"

# Copy configurations
cp -r "$SCRIPT_DIR/.config/"* "$HOME/.config/"
if [ -d "$SCRIPT_DIR/Wallpapers" ]; then
    cp -r "$SCRIPT_DIR/Wallpapers/"* "$HOME/Pictures/Wallpapers/" 2>/dev/null || true
fi

# Ensure executable permissions on all custom scripts
chmod +x "$HOME"/.config/hypr/scripts/*.sh 2>/dev/null || true

# Symlink konsole -> kitty for seamless Dolphin terminal compatibility
sudo ln -sf /usr/bin/kitty /usr/bin/konsole

# Configure KDE globals for default terminal
kwriteconfig6 --file kdeglobals --group General --key TerminalApplication "kitty" 2>/dev/null || true
kwriteconfig6 --file kdeglobals --group General --key TerminalService "kitty.desktop" 2>/dev/null || true

# Configure Default Text Editor (VS Code) & Nano for Terminal
mkdir -p "$HOME/.config"
cat << 'MIMEOF' > "$HOME/.config/mimeapps.list"
[Default Applications]
text/plain=code.desktop
text/markdown=code.desktop
text/x-markdown=code.desktop
text/x-c=code.desktop
text/x-c++=code.desktop
text/x-python=code.desktop
text/x-shellscript=code.desktop
application/x-shellscript=code.desktop
application/json=code.desktop
text/javascript=code.desktop
text/html=google-chrome.desktop
text/css=code.desktop
text/x-go=code.desktop
text/x-java=code.desktop
text/x-lua=code.desktop
application/xml=code.desktop
text/xml=code.desktop
text/x-yaml=code.desktop
application/x-yaml=code.desktop
x-scheme-handler/http=google-chrome.desktop
x-scheme-handler/https=google-chrome.desktop
x-scheme-handler/about=google-chrome.desktop
x-scheme-handler/unknown=google-chrome.desktop
MIMEOF

# Set default terminal editor in ~/.bashrc
grep -q "export EDITOR=nano" "$HOME/.bashrc" 2>/dev/null || echo -e "\n# Default Terminal Editor\nexport EDITOR=\"nano\"\nexport VISUAL=\"nano\"" >> "$HOME/.bashrc"

# Initialize standard user directories
xdg-user-dirs-update

# 6. Enable Essential System Services
echo -e "${YELLOW}==> [6/7] Enabling system background services...${NC}"
sudo systemctl enable --now bluetooth.service 2>/dev/null || true
sudo systemctl enable --now power-profiles-daemon.service 2>/dev/null || true
sudo systemctl enable --now ufw.service 2>/dev/null || true
sudo systemctl enable --now iwd.service 2>/dev/null || true

# UFW initial rules
sudo ufw default deny incoming 2>/dev/null || true
sudo ufw default allow outgoing 2>/dev/null || true
sudo ufw --force enable 2>/dev/null || true

# 7. Finishing up
echo -e "\n${GREEN}${BOLD}======================================================"
echo "  INSTALLATION COMPLETED SUCCESSFULLY!"
echo "======================================================${NC}"
echo -e "${CYAN}Semua konfigurasi Hyprland Nord Minimalist Sharp siap digunakan.${NC}"
echo -e "${YELLOW}Silakan logout / restart laptop Anda untuk menikmati pengalaman penuh.${NC}\n"
