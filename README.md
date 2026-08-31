# ❄️ Hyprland Nord Minimalist & Sharp Dotfiles

A clean, modern, ultra-lightweight, and fully-functional Hyprland setup tailored for Arch Linux with authentic **Nord Theme** and **Sharp 0px Borders**.

---

## ✨ Features & Highlights

- **Desktop Window Manager**: Hyprland configured in Lua (`~/.config/hypr/hyprland.lua`).
- **Aesthetic**: 100% Sharp Square (0px rounded corners) + Authentic Nord Color Palette.
- **Top Status Bar**: Full-width edge-to-edge Waybar (CPU, RAM, Disk, Battery, Network, Bluetooth, Audio, Brightness, Notifications, & Clock).
- **Application Launcher**: Minimalist left sidebar Rofi launcher with instant app search.
- **Terminal**: Kitty customized with JetBrains Mono Nerd Font and Nord color scheme.
- **TUI Management**: 
  - 󰖩 **WiFi**: `Impala` (TUI WiFi network manager)
  - 󰂯 **Bluetooth**: `Bluetuith` (TUI Bluetooth manager)
  - 󰍛 **System Monitor**: `btop` (Real-time CPU/RAM/Disk monitor)
- **Visual HUD/OSD**: Brightness & Volume HUD overlays on Fn-keys.
- **Dynamic Wallpaper Switcher**: Press `Super + W` to randomly swap wallpapers from `~/Pictures/Wallpapers/`.
- **Daily Driver Ready**: Auto power profiles daemon, UFW firewall, flashdisk/HDD support (NTFS, FAT32, exFAT), and archive extract tools.

---

## ⌨️ Keybindings Reference

| Shortcut | Action |
| :--- | :--- |
| **`Super + Return`** | Open Terminal (**Kitty**) |
| **`Super + Q`** | Close / Kill active window |
| **`Super + B`** | Open Browser (**Google Chrome**) |
| **`Super + E`** | Open File Manager (**Dolphin**) |
| **`Super + Shift + S`** | Area Screenshot (auto copies to clipboard & saves to `~/Pictures/Screenshots/`) |
| **`Super + Space`** / **`Super + D`** | Open Left Sidebar App Launcher (**Rofi**) |
| **`Super + W`** | Change Wallpaper dynamically from `~/Pictures/Wallpapers/` |
| **`Super + N`** | Toggle Notification Center (**SwayNC**) |
| **`Super + L`** | Lock Screen (**Hyprlock**) |
| **`Super + M`** | Exit / Logout Hyprland |
| **`Super + F`** | Toggle Fullscreen |
| **`Super + V`** | Toggle Floating Window |
| **`Super + 1-10`** | Switch to Workspace 1–10 |
| **`Super + Shift + 1-10`**| Move active window to Workspace 1–10 |
| **`Super + H / J / K / L`**| Move focus between windows (Vim keys) |
| **`Fn + Volume / Brightness`** | Adjust sound & backlight with visual OSD HUD |

---

## 🚀 One-Line Installation (Fresh Arch Linux)

After completing `archinstall`, run the following commands in your terminal:

```bash
git clone https://github.com/Irsyadmr354/Hyprland-nord-dotfiles.git
cd Hyprland-nord-dotfiles
chmod +x install.sh
./install.sh
```

Everything will be downloaded, configured, and deployed automatically!
EOF
