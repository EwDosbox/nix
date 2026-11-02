{
  config,
  pkgs,
  inputs,
  ...
}: {
  home = {
    username = "hartie";
    homeDirectory = "/home/hartie";

    packages = with pkgs; [
      # General
      vlc
      vesktop # Discord
      inputs.zen-browser.packages.${pkgs.system}.default
      telegram-desktop

      #VSCodium
      vscodium
      ruff
      clang-tools
      alejandra
      jdk

      # Photo
      krita
      digikam
      xnviewmp

      # File
      obsidian
      thunar

      # Spotify
      librespot
      spotify-qt

      # Git
      lazygit
      gh
    ];

    file = {
      ".local/bin/mkdev" = {
        source = ./../scripts/mkdev.sh;
        executable = true;
      };
      ".local/bin/update" = {
        source = ./../scripts/update.sh;
        executable = true;
      };
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
          terminal = "footclient -e";
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

    vscodium = {
      enable = true;

      profiles.default = {
        userSettings = {
          "telemetry.telemetryLevel" = "off";
          "crashReporter.enabled" = false;
          "update.mode" = "none";

          "editor.fontSize" = 14;
          "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
          "editor.formatOnSave" = true;
          "editor.tabSize" = 4;
          "files.autoSave" = "onFocusChange";

          "editor.quickSuggestions" = {
            "other" = "on";
            "comments" = "off";
            "strings" = "on";
          };
          "editor.suggestOnTriggerCharacters" = true;
          "editor.wordBasedSuggestions" = "matchingDocuments";

          "[python]" = {"editor.defaultFormatter" = "charliermarsh.ruff";};
          "[html]" = {"editor.defaultFormatter" = "esbenp.prettier-vscode";};
          "[css]" = {"editor.defaultFormatter" = "esbenp.prettier-vscode";};
          "[javascript]" = {"editor.defaultFormatter" = "esbenp.prettier-vscode";};
          "[json]" = {"editor.defaultFormatter" = "esbenp.prettier-vscode";};
          "[cpp]" = {"editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";};
          "[nix]" = {"editor.defaultFormatter" = "kamadorueda.alejandra";};

          "workbench.colorTheme" = "Dracula";
          "workbench.iconTheme" = "material-icon-theme";

          "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
        };

        keybindings = [
          {
            key = "ctrl+alt+f";
            command = "editor.action.formatDocument";
          }
        ];

        extensions = with pkgs.vscode-extensions; [
          # General
          dracula-theme.theme-dracula
          pkief.material-icon-theme
          tomoki1207.pdf
          # Nix
          bbenoist.nix
          kamadorueda.alejandra
          # Python
          ms-python.python
          charliermarsh.ruff
          # C#
          ms-dotnettools.csharp
          # C++
          llvm-vs-code-extensions.vscode-clangd
          # Java
          redhat.java
          # Web
          ritwickdey.liveserver
          esbenp.prettier-vscode
          # Godot
          geequlim.godot-tools
          # PV004
          ms-vscode.cmake-tools
          # PB130
          oracle.oracle-java
          # PB016
          ms-toolsai.jupyter
        ];
      };
    };
  };

  xdg = {
    desktopEntries.xnviewmp = {
      name = "XnView MP";
      comment = "Graphic file viewer and converter";
      exec = "xnviewmp %F";
      terminal = false;
      categories = ["Graphics" "Viewer"];
      mimeType = ["image/jpeg" "image/png" "image/gif" "image/tiff" "image/webp"];
    };

    userDirs = {
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
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
