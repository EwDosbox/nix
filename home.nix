{ config, pkgs, inputs, ... }:

{
  home.username = "hartie";
  home.homeDirectory = "/home/hartie";

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default

    imagej

    krita
    digikam
    xnviewmp
    obsidian
    vlc
    vesktop # Discord
    megacmd # MegaSync
    thunar # File
    # Spotify
    librespot 
    spotify-qt
    # Git
    lazygit
    gh
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;

    extraConfig = builtins.readFile ./sway.conf;
  };

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };
  
  # Git
  services.ssh-agent.enable = true;

  programs.fish = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
    setSessionVariables = false;
    download = "$HOME/downloads";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
