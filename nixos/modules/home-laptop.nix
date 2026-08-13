{
    config,
    lib,
    pkgs,
    pkgs-stable,
    ...
}:

{
    imports = [ ./hardware/home-laptop.nix ];
    networking.hostName = "nixos-home";
    services.flatpak.enable = true;

    programs.steam.enable = true;
    networking.nameservers = [
        "100.100.100.100"
        "1.1.1.1"
        "8.8.8.8"
    ];

    virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
    };
    users.extraGroups.vboxusers.members = [ "odo59" ];

    environment.systemPackages = with pkgs; [
        pkgs-stable.qgis
        discord
        scrcpy
    ];

    virtualisation.docker = {
        enable = false;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    users.users.odo59.extraGroups = [ "docker" ];
}
