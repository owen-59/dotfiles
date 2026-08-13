{
    config,
    lib,
    pkgs,
    inputs,
    nsa,
    ...
}:

{
    imports = [
        ./hyprlandLuaConfig.nix
        ./pkgs.nix
        inputs.silentSDDM.nixosModules.default
    ];

    users.users.odo59 = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "input"
            "mlocate"
        ];
    };

    nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-users = [ "root" "odo59" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    boot = {
        initrd.systemd.enable = true;
        # Use the systemd-boot EFI boot loader.
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
    };

    # wifi
    networking = {
        networkmanager.enable = true;
        # networkmanager.dns = "none";
        nftables.enable = true;
        resolvconf.enable = false;
        firewall = {
            checkReversePath = "loose";
            allowedUDPPorts = [ config.services.tailscale.port ];
            allowedTCPPorts = [ 9090 ];
        };
    };

    systemd.network.wait-online.enable = false;
    systemd.services.resolvconf.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;

    time.timeZone = "Australia/Melbourne";

    nixpkgs.config = {
        allowUnfree = true;
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    environment.sessionVariables = rec {
        NIXOS_OZONE_WL = "1";
        HYPRSHOT_DIR = "/home/odo59/Screenshots";
    };

    environment.variables = rec {
        SHELL = "fish";
    };

    swapDevices = [
        {
            device = "/swapfile";
            size = 16 * 1024;
        }
    ];

    console.keyMap = "dvorak";

    home-manager.backupFileExtension = "backup";

    services = {
        # sound
        pipewire = {
            enable = true;
            pulse.enable = true;
        };

        syncthing = {
            enable = true;
            user = "odo59";
            dataDir = "/home/odo59";
            configDir = "/home/odo59/.config/syncthing";
            openDefaultPorts = false;
        };

        resolved.enable = true;
        upower.enable = true;

        # touchpad support
        libinput.enable = true;
        logind.settings.Login.HandlePowerKey = "ignore";
    };

    # bluetooth
    hardware.bluetooth.enable = true;

    # enable nix-command
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    # Programs
    programs = {
        hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        };
        nix-ld.enable = true;
    };

    services = {
        blueman.enable = true;
        tailscale.enable = true;
        desktopManager.plasma6.enable = true;
    };
    programs.silentSDDM = {
        enable = true;
        theme = "default";
    };

    services.displayManager.sddm = {
        enable = true;
    };

    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "dvorak";
    };

    # wayland security
    security.polkit.enable = true;
    security.wrappers."mount.cifs" = {
        program = "mount.cifs";
        source = "${lib.getBin pkgs.cifs-utils}/bin/mount.cifs";
        owner = "root";
        group = "root";
        setuid = true;
    };


    xdg.portal.enable = true;

    users.groups.mlocate = { };

    fonts.fontconfig.enable = true;

    fonts.packages = with pkgs; [
        noto-fonts
        font-awesome
        roboto
        barlow
        inter
        googlesans-code
        nerd-fonts.fira-code
        nerd-fonts.monaspace
    ];

    system.stateVersion = "25.11"; # DO NOT CHANGE
}
