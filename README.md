# Hyprland Monochrome Dotfiles

A clean, modern, ultra-lightweight, and fully-functional Hyprland setup for Arch Linux with a monochrome black-white theme. Base colors are soft black (#141414, not pure black) and off-white (#EDEDED). Red/amber accents are reserved strictly for urgency states such as critical battery.

## Features and Highlights

- **Desktop Window Manager**: Hyprland configured in Lua (`~/.config/hypr/hyprland.lua`), windows keep rounded corners.
- **Aesthetic**: Monochrome black-white throughout Kitty, Rofi, SwayNC, and Hyprlock.
- **Top Status Bar**: Full-width flat Waybar, 36px tall with no radius. Active workspace uses white-on-black, window title renders in white.
- **Application Launcher**: Tall floating Rofi panel on the left, stretching from below Waybar to the bottom of the screen. Dismiss with ESC or click-outside.
- **Notification Center**: SwayNC control-center as a tall floating panel on the right, regular notifications appear at the top-right corner. Toggle with Super+N.
- **Terminal**: Kitty with monochrome colors and JetBrains Mono Nerd Font.
- **Powermenu**: Centered rounded Rofi powermenu in monochrome style.
- **TUI Management**:
  - **WiFi**: `Impala` (TUI WiFi network manager)
  - **Bluetooth**: `Bluetuith` (TUI Bluetooth manager)
  - **System Monitor**: `btop` (Real-time CPU/RAM/Disk monitor)
- **Visual HUD/OSD**: Brightness and Volume HUD overlays on Fn-keys.
- **Dynamic Wallpaper Switcher**: Press `Super + W` to randomly swap wallpapers from `~/Pictures/Wallpapers/`.
- **Daily Driver Ready**: Auto power profiles daemon, UFW firewall, flashdisk/HDD support (NTFS, FAT32, exFAT), and archive extract tools.

---

## Keybindings Reference

| Shortcut | Action |
| :--- | :--- |
| **`Super + Return`** | Open Terminal (**Kitty**) |
| **`Super + Q`** | Close / Kill active window |
| **`Super + B`** | Open Browser (**Google Chrome**) |
| **`Super + E`** | Open File Manager (**Dolphin**) |
| **`Super + Shift + S`** | Area Screenshot (auto copies to clipboard and saves to `~/Pictures/Screenshots/`) |
| **`Super + Space`** / **`Super + D`** | Open floating app launcher panel (**Rofi**) |
| **`Super + X`** | Open powermenu (**Rofi**) |
| **`Super + W`** | Change Wallpaper dynamically from `~/Pictures/Wallpapers/` |
| **`Super + N`** | Toggle Notification Center (**SwayNC**) |
| **`Super + L`** | Lock Screen (**Hyprlock**) |
| **`Super + M`** | Exit / Logout Hyprland |
| **`Super + F`** | Toggle Fullscreen |
| **`Super + V`** | Toggle Floating Window |
| **`Super + 1-10`** | Switch to Workspace 1-10 |
| **`Super + Shift + 1-10`**| Move active window to Workspace 1-10 |
| **`Super + H / J / K / L`**| Move focus between windows (Vim keys) |
| **`Fn + Volume / Brightness`** | Adjust sound and backlight with visual OSD HUD |

---

## One-Line Installation (Fresh Arch Linux)

After completing `archinstall`, run the following commands in your terminal:

```bash
git clone https://github.com/Irsyadmr354/Hyprland-dotfiles.git
cd Hyprland-dotfiles
chmod +x install.sh
./install.sh
```

Everything will be downloaded, configured, and deployed automatically!
