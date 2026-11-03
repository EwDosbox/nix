{
  config,
  lib,
  pkgs,
  inputs,
  deviceName,
  ...
}:
with lib; let
  deviceIds = {
    phone = "YDBKFQM-BFEIWUD-O6UXCKJ-7KVZK6U-TT7VYW4-TJHUSDB-QO4GFIX-REHMDQJ";
    pc = "MHLZOIS-3UXFVLD-2GRZVPL-LZB57JC-AN2K7ZC-34UIVW7-46Q5MET-BH5PWAV";
    laptop = "2WLQ2E2-ZCI7J2B-FQNNKF5-UHZ7DA2-X3DB4ZR-ARESHBT-AFSV4VV-LYOHMQE";
    kot = "LZOUY6H-EF6OQX7-VTN26U5-KPGXV5Q-562CLCU-CXUMVJB-V5A6FNT-4K5YDQV";
  };
in {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
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
          "phone" = {id = deviceIds.phone;};
          "kot" = {id = deviceIds.kot;};
          "peer-device" = {
            # If we are on the PC, add the laptop as a peer. If on the laptop, add the PC.
            id =
              if deviceName == "pc"
              then deviceIds.laptop
              else deviceIds.pc;
          };
        };

        folders = {
          "media-files" = {
            path = "/home/hartie/2_media";
            devices = ["phone"];
          };
          "uni-files" = {
            path = "/home/hartie/3_uni";
            devices = ["phone" "peer-device"];
          };
          "rest-files" = {
            path = "/home/hartie/4_inbox";
            devices = ["phone" "peer-device"];
          };
          "share-kot" = {
            path = "/home/hartie/5_share/1_kot";
            devices = ["kot"];
          };
          "share-hartie" = {
            path = "/home/hartie/5_share/2_hartie";
            devices = ["phone"];
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

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    gnome.gnome-keyring.enable = true;
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
    extraGroups = ["networkmanager" "wheel" "video" "audio"];
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

    nix-ld.enable = true;
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
      # Dark Theme
      adwaita-qt
      adwaita-icon-theme
      glib
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
      unzip
      killall
      # Apps
      mariadb # For Digikam
    ];

    variables.BROWSER = "zen";

    # Dark Mode
    sessionVariables = {
      GTK_THEME = "Adwaita:dark";

      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_STYLE_OVERRIDE = "adwaita-dark";

      MOZ_ENABLE_WAYLAND = "1";
    };

    etc."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
      gtk-theme-name=Adwaita-dark
    '';

    etc."gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
      gtk-theme-name=Adwaita-dark
    '';

    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  system.stateVersion = "24.11";
}
