{
    pkgs,
    ...
}: {
    system.activationScripts.writeHyprlandLuaConfig = {
        text = ''
            echo {\"workspace\": {\"library\": [\"${pkgs.hyprland}/share/hypr/stubs/\"]}} \
            > /home/odo59/.config/hypr/.luarc.json
            chown odo59:users /home/odo59/.config/hypr/.luarc.json
        '';
        deps = [];
    };
}
