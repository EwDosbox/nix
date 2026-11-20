{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ./foot.nix
    ./vscodium.nix
    ./waybar.nix
  ];
  home = {
    username = "kot";
    homeDirectory = "/home/kot";

    packages = with pkgs; [
      # General
      firefox
      vlc

      # Fonts
      courier-prime
      # Clipboard and Screenshot
      wl-clipboard
      grim
      slurp
    ];

    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;

    extraConfig = builtins.readFile ./../dots/sway.conf;
  };

  services = {
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };

    ssh-agent.enable = true;
  };

  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting ""

        fastfetch
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono:size=14";
          dpi-aware = "no";
          prompt = "❯  ";
          lines = 16;
          width = 50;
          tabs = 4;
          horizontal-pad = 50;
          vertical-pad = 18;
          inner-pad = 10;
          image-size-ratio = "0.25";
          exit-on-keyboard-focus-loss = "no";
          terminal = "foot -e";
        };

        colors = {
          background = "2e3440dd";
          text = "eceff4ff";
          prompt = "81a1c1ff";
          placeholder = "81a1c1ff";
          input = "81a1c1ff";
          match = "88c0d0ff";
          selection-match = "88c0d0ff";
          selection = "4c566add";
          selection-text = "eceff4ff";
          border = "81a1c1ff";
        };
      };
    };
  };

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "24.11";
}
