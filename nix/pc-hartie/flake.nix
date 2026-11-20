{
  description = "Flake of Hartie PC";

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
    nixosConfigurations.pc-hartie = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        system = system;
        inherit inputs pkgs-unstable;
        deviceName = "hartie-pc";
      };
      modules = [
        ./hardware-configuration.nix
        ../configuration.nix
        ({
          config,
          lib,
          pkgs,
          ...
        }: {
          boot.loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };

          hardware.nvidia = {
            open = true;
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
          };

          programs.sway.extraOptions = ["--unsupported-gpu"];
          services.greetd.settings.default_session.command =
            lib.mkForce
            "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd 'sway --unsupported-gpu'";

          services.xserver.videoDrivers = ["nvidia"];

          environment.sessionVariables = {
            WLR_NO_HARDWARE_CURSORS = "1";
          };
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {inherit inputs pkgs-unstable;};
          home-manager.users.hartie = import ../hartie-home.nix;
          home-manager.users.kot = import ../kot-home.nix;
        }
      ];
    };
  };
}
