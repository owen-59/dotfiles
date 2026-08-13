{
    description = "flake for nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland = {
            url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        silentSDDM = {
            url = "github:uiriansan/SilentSDDM";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nsa = {
            url = "github:owen-59/nsa";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        {
            self,
            nixpkgs,
            nixpkgs-stable,
            hyprland,
            nsa,
            ...
        }@inputs:
        let
            mkStablePkgs = system: import nixpkgs-stable {
                inherit system;
                config.allowUnfree = true;
            };

            mkSystem = { system, hostname, hyprlandConfig }:
                let
                    pkgs-stable = mkStablePkgs system;
                in
                nixpkgs.lib.nixosSystem {
                    inherit system;
                    specialArgs = {
                        inherit inputs pkgs-stable nsa;
                    };

                    modules = [
                        ./modules/config.nix
                        ./modules/${hostname}.nix
                        inputs.home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = {
                                inherit inputs pkgs-stable;
                            };
                            home-manager.users.odo59.imports = [
                                ./home.nix
                                hyprlandConfig
                            ];
                        }
                    ];
                };
        in
        {
            nixosConfigurations = {
                laptop = mkSystem {
                    system = "aarch64-linux";
                    hostname = "laptop";
                    hyprlandConfig = ./modules/hyprland/laptop.nix;
                };

                home-laptop = mkSystem {
                    system = "x86_64-linux";
                    hostname = "home-laptop";
                    hyprlandConfig = ./modules/hyprland/home-laptop.nix;
                };
            };
        };
}

