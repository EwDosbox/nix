{
  description = "Flake of Hartie Laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    zen-browser,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.laptop-hartie = nixpgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        system = system;
        inherit inputs pkgs-unstable;
        deviceName = "hartie-laptop";
      };
      modules = [
        ./hardware-configuration.nix
        ../configuration.nix
        ({pkgs, ...}: {
          boot.loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };

          hardware.graphics.extraPackages = with pkgs; [
            intel-media-driver
            vpl-gpu-rt
          ];
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {inherit inputs pkgs-unstable;};
          home-manager.users.hartie = import ../hartie-home.nix;
        }
      ];
    };
  };
}
