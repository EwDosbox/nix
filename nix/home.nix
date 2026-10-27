{ config, pkgs, inputs, ... }:

{
  home = {
    username = "hartie";
    homeDirectory = "/home/hartie";

    packages = with pkgs; [
      inputs.zen-browser.packages.${pkgs.system}.default

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

    file.".local/bin/mkdev" = {
      source = ./../scripts/mkdev.sh;
      executable = true;
    };
    file.".local/bin/update" = {
      source = ./../scripts/update.sh;
      executable = true;
    };

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
    createDirectories = true;
    setSessionVariables = true;
    download = "${config.home.homeDirectory}/downloads";
    pictures = "${config.home.homeDirectory}/2_media/TOSORT";
    videos = "${config.home.homeDirectory}/2_media/TOSORT";
    music = "${config.home.homeDirectory}/2_media/TOSORT";
    desktop = "${config.home.homeDirectory}/4_inbox/0_desktop"; 
    documents = "${config.home.homeDirectory}/4_inbox/1_inbox"; 
    projects = "${config.home.homeDirectory}/4_inbox/1_inbox"; 
    templates = "${config.home.homeDirectory}/4_inbox/1_inbox"; 
    publicShare = "${config.home.homeDirectory}/4_inbox/1_inbox"; 
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
