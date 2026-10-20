{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hartie-pc";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true; # Graphical Bluetooth manager applet

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.fish.enable = true;

  users.users.hartie = {
    isNormalUser = true;
    description = "hartie";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  programs.steam = {
      enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Enviroment
    fuzzel
    waybar
    mako
    pavucontrol
    wl-clipboard
    brightnessctl
    networkmanagerapplet
    kanshi
    # Development
    ghc
    dotnet-sdk
    gcc
    python3
    # Terminal
    git
    foot
    wget
    curl
    micro
    fastfetch
    htop
    # Apps
    vscode
 ];

  system.stateVersion = "24.11";
}
