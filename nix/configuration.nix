{ config, lib, pkgs, inputs, deviceName, ... }:

with lib;

let
  deviceIds = {
    phone = "YDBKFQM-BFEIWUD-O6UXCKJ-7KVZK6U-TT7VYW4-TJHUSDB-QO4GFIX-REHMDQJ";
    pc = "MHLZOIS-3UXFVLD-2GRZVPL-LZB57JC-AN2K7ZC-34UIVW7-46Q5MET-BH5PWAV";
    laptop = "2WLQ2E2-ZCI7J2B-FQNNKF5-UHZ7DA2-X3DB4ZR-ARESHBT-AFSV4VV-LYOHMQE";
  };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "${deviceName}";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

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

  services.syncthing = {
    enable = true;
    user = "hartie";
    dataDir = "/home/hartie";
    openDefaultPorts = true;

    settings = {
      devices = {
        "phone" = { id = deviceIds.phone; };
        "peer-device" = { # If we are on the PC, add the laptop as a peer. If on the laptop, add the PC.
          id = if deviceName == "pc" then deviceIds.laptop else deviceIds.pc; 
        };
      };

      folders = {
        "media-files" = {
          path = "/home/hartie/2_media";
          devices = [ "phone" ];
        };
        "uni-files" = {
          path = "/home/hartie/3_uni";
          devices = [ "phone" "peer-device" ];
        };
        "rest-files" = {
          path = "/home/hartie/4_inbox";
          devices = [ "phone" "peer-device" ];
        };
      };
    };
  };
  

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
