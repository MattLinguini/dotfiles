{
  description = "Flake for my NixOS System";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, lanzaboote, ...} @ inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      "thinkpad" = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/thinkpad/configuration.nix

          lanzaboote.nixosModules.lanzaboote ({ pkgs, lib, ... }: {
            environment.systemPackages = [ pkgs.sbctl ];

            boot.loader.systemd-boot.enable = lib.mkForce false;
            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/etc/secureboot";  
            };
          })

        ];
      };
    };

    homeConfigurations = {
      matt = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ ./modules/nixos/user/home-manager/home.nix ];
      }; 
    };
  };
}
