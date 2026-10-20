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

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "${deviceName}";
    networkmanager.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
    };
  };

  services = {
    blueman.enable = true;

    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    xserver.enable = true;
    xserver.displayManager.lightdm.enable = true;

    udisks2.enable = true;
    gvfs.enable = true;

    syncthing = {
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

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
  };

  time.timeZone = "Europe/Prague";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "cs_CZ.UTF-8";
      LC_IDENTIFICATION = "cs_CZ.UTF-8";
      LC_MEASUREMENT = "cs_CZ.UTF-8";
      LC_MONETARY = "cs_CZ.UTF-8";
      LC_NAME = "cs_CZ.UTF-8";
      LC_NUMERIC = "cs_CZ.UTF-8";
      LC_PAPER = "cs_CZ.UTF-8";
      LC_TELEPHONE = "cs_CZ.UTF-8";
      LC_TIME = "cs_CZ.UTF-8";
    };
  };


  users.users.hartie = {
    isNormalUser = true;
    description = "hartie";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };
  
  programs = {
    fish.enable = true;

    sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
    };

    steam = {
      enable = true;
    };
  };

  security.rtkit.enable = true;

  environment = {
    systemPackages = with pkgs; [
        # Enviroment
        fuzzel
        waybar
        mako
        pavucontrol
        betterlockscreen
        # Drivers and such
        bluez
        bluez-tools
        bluez-alsa
        wl-clipboard
        playerctl
        brightnessctl
        networkmanagerapplet
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
        btop
        tree
        qalculate-qt
        # Apps
        vscode
    ];
    variables.BROWSER = "zen";
  };

  system.stateVersion = "24.11";
}
