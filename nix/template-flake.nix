{
  description = "Universal Dev Environment Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }:
    let
      # Support system architecture
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        # 1. Add tools/compilers needed for this project here
        buildInputs = with pkgs; [
          # Examples: gcc, python3, jdk, ghc, cmake, etc.
          gcc
          gnumake
        ];

        # 2. Environment variables or setup scripts to run when entering shell
        shellHook = ''
          echo "🚀 Dev shell loaded via Nix + direnv!"
        '';
      };
    };
}