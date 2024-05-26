{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
           url = "github:nix-community/home-manager";
           inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixpkgs, home-manager, ...}@inputs: {
        nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ 
                ./base-configuration.nix
                ./desktop-configuration.nix
                home-manager.nixosModules.home-manager
                {
                    nixpkgs.overlays = [
                      # (import (builtins.fetchTarball {
                      #   url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
                      # ))
                    ];
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.vivax = import ./desktop-home.nix;
                }
            ];
        };
        nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ 
                ./base-configuration.nix
                ./wsl-configuration.nix
                home-manager.nixosModules.home-manager
                {
                    nixpkgs.overlays = [
                      # (import (builtins.fetchTarball {
                      #   url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
                      # }))
                    ];
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.nixos = import ./wsl-home.nix;
                }
            ];
        };
    };
}
