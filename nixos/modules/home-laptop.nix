{
    config,
    lib,
    pkgs,
    ...
}:

{
    imports = [ ./hardware/home-laptop.nix ];
    networking.hostName = "nixos-home";
    services.flatpak.enable = true;

    programs.steam.enable = true;
    programs.virt-manager.enable = true;
    networking.nameservers = [
        "100.100.100.100"
        "1.1.1.1"
        "8.8.8.8"
    ];

    environment.systemPackages = with pkgs; [
        postman
        qgis
        discord
        scrcpy
    ];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.docker = {
        enable = false;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    users.users.odo59.extraGroups = [ "docker" ];
}
