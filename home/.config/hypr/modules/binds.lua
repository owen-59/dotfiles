local monitor_tools = require("modules.scripts.monitor_tools")

local terminal = "alacritty"
local fileManager = "dolphin"
local menu = "pidof rofi || rofi -show drun"
local browser = "floorp"
local wlogout = "pkill wlogout || wlogout"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + Z", hl.dsp.window.close({}))
hl.bind("SUPER + M", hl.dsp.exec_cmd(wlogout))
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(menu))
-- switch keyboard layout here
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(".config/scripts/volume up"),     { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(".config/scripts/volume down"),   { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(".config/scripts/volume mute"),   { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("SUPER + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + left", hl.dsp.focus({ workspace = "r-1" }))
for n = 1, 9 do
    hl.bind("SUPER + " .. n, function() hl.dispatch(
            hl.dsp.focus({
                workspace = tostring(monitor_tools.get_relative_workspace(n))
            })
        ) end)
end

for n = 1, 9 do
    hl.bind("SUPER + SHIFT + " .. n, hl.dsp.window.move({ workspace = n }))
end


hl.gesture({fingers = 3, direction = "horizontal", action = "workspace"})
