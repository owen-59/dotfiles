{
    config,
    lib,
    pkgs,
    ...
}:

{
    imports = [
        ./hardware/laptop.nix
    ];

    hardware.asahi.enable = true;

    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
}
