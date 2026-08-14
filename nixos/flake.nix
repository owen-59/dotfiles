{
    description = "flake for nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/26.05";

        apple-silicon-support.url = "github:nix-community/nixos-apple-silicon";
        apple-silicon-support.inputs.nixpkgs.follows = "nixpkgs";

        home-manager = {
            url = "github:nix-community/home-manager";
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
            apple-silicon-support,
            nsa,
            ...
        }@inputs:
        let
            mkSystem = { system, hostname, extraModules }:
                nixpkgs.lib.nixosSystem {
                    inherit system;
                    specialArgs = {
                        inherit inputs nsa;
                    };

                    modules = [
                        ./modules/config.nix
                        ./modules/${hostname}.nix
                        inputs.home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = {
                                inherit inputs;
                            };
                            home-manager.users.odo59.imports = [
                                ./home.nix
                            ];
                        }
                    ] ++ extraModules;
                };
        in
        {
            nixosConfigurations = {
                laptop = mkSystem {
                    system = "aarch64-linux";
                    hostname = "laptop";
                    extraModules = [ apple-silicon-support.nixosModules.apple-silicon-support ];
                };

                home-laptop = mkSystem {
                    system = "x86_64-linux";
                    hostname = "home-laptop";
                };
            };
        };
}

