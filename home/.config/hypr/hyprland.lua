require("modules.animations")
require("modules.binds")
require("modules.input")
require("modules.autostart")
require("modules.general")
require("modules.misc")

local hostname = io.popen("hostname"):read("*l")
local isLaptop = hostname == "nixos"

if isLaptop then
    hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "auto",
        scale = 1.67,
    })
else
    hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true})
    hl.workspace_rule({ workspace = "2", monitor = "eDP-1"})
    hl.workspace_rule({ workspace = "3", monitor = "eDP-1"})
    hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1", default = true})
    hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1"})
    hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1"})

    hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "auto",
        scale = 1.33,
    })

    hl.monitor({
        output = "HDMI-A-1",
        mode = "preferred",
        position = "auto-center-left",
        scale = 1,
    })
end
