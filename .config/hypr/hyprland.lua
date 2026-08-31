-- ~/.config/hypr/hyprland.lua
-- Minimalist, Clean, Fast & Modern Hyprland Configuration

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"
local browser     = "google-chrome-stable"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function ()
    hl.exec_cmd("~/.config/hypr/scripts/autostart.sh")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 4,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(88c0d0ff)", "rgba(81a1c1ff)"}, angle = 45 },
            inactive_border = "rgba(4c566aaa)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 0,

        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled      = true,
            range        = 10,
            render_power = 2,
            color        = 0x6611111b,
        },

        blur = {
            enabled          = true,
            size             = 5,
            passes           = 2,
            vibrancy         = 0.1696,
            new_optimizations = true,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Animation curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true,  speed = 6,   bezier = "easeOutQuint" })
hl.animation({ leaf = "border",        enabled = true,  speed = 4,   bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 3.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 3.5, bezier = "easeOutQuint", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 3,   bezier = "easeOutQuint", style = "popin 80%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 2,   bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 2,   bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 3.5, bezier = "easeOutQuint", style = "slide" })

-----------------
---- LAYOUTS ----
-----------------
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- 1. Super + Return (terminal)
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))

-- 2. Super + Q (kill window / terminal)
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- 3. Super + B (browser)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- 4. Super + E (file manager)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- 5. Super + Shift + S (screenshot)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png && notify-send 'Screenshot' 'Saved & Copied to Clipboard'"))

-- Extra essential binds
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + D",     hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F",     hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + V",     hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",     hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",     hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + W",     hl.dsp.exec_cmd("~/.config/hypr/scripts/change_wallpaper.sh"))
hl.bind(mainMod .. " + N",     hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + L",     hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + X",     hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh"))
hl.bind(mainMod .. " + M",     hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Focus window with arrow keys & vim keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + h",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j",     hl.dsp.focus({ direction = "down" }))

-- Move window with arrow keys & vim keys
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + h",     hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l",     hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k",     hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j",     hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces 1-10
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Mouse bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio & brightness controls with visual OSD progress bar
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("/home/royan/.config/hypr/scripts/volume.sh raise"),      { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("/home/royan/.config/hypr/scripts/volume.sh lower"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("/home/royan/.config/hypr/scripts/volume.sh mute"),       { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("/home/royan/.config/hypr/scripts/brightness.sh raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("/home/royan/.config/hypr/scripts/brightness.sh lower"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"),                         { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),                               { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),                           { locked = true })

----------------------
---- WINDOW RULES ----
----------------------
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "float-pavucontrol",
    match = { class = "pavucontrol" },
    float = true,
})

hl.window_rule({
    name = "float-nwg-look",
    match = { class = "nwg-look" },
    float = true,
})
