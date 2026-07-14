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
    };

    outputs =
        {
            self,
            nixpkgs,
            nixpkgs-stable,
            hyprland,
            ...
        }@inputs:
        let
            mkStablePkgs = system: import nixpkgs-stable {
                inherit system;
                config.allowUnfree = true;
            };
        in
        {
            nixosConfigurations = {
                laptop = let
                    system = "aarch64-linux";
                    pkgs-stable = mkStablePkgs system;
                in nixpkgs.lib.nixosSystem {
                    inherit system;
                    specialArgs = {
                        inherit inputs pkgs-stable;
                    };

                    modules = [
                        ./modules/config.nix
                        ./modules/laptop.nix
                        inputs.home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = {
                                inherit inputs pkgs-stable;
                            };
                            home-manager.users.odo59.imports = [
                                ./home.nix
                                ./modules/hyprland/laptop.nix
                            ];
                        }
                    ];
                };

                home-laptop = let
                    system = "x86_64-linux";
                    pkgs-stable = mkStablePkgs system;
                in nixpkgs.lib.nixosSystem {
                    inherit system;
                    specialArgs = {
                        inherit inputs pkgs-stable;
                    };

                    modules = [
                        ./modules/config.nix
                        ./modules/home-laptop.nix
                        inputs.home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = {
                                inherit inputs pkgs-stable;
                            };
                            home-manager.users.odo59.imports = [
                                ./home.nix
                                ./modules/hyprland/home-laptop.nix
                            ];
                        }
                    ];
                };
            };
        };
}
