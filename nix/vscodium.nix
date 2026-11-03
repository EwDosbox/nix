{pkgs, ...}: {
  programs.vscodium = {
    enable = true;

    profiles.default = {
      userSettings = {
        "telemetry.telemetryLevel" = "off";
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
        "[haskell]" = {"editor.defaultFormatter" = "haskell.haskell";};
        "[java]" = {"editor.defaultFormatter" = "redhat.java";};

        "workbench.colorTheme" = "Dracula Theme Soft";
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
        # Haskell
        haskell.haskell
        # PV004
        ms-vscode.cmake-tools
        # PB130
        oracle.oracle-java
        # PB016
        ms-toolsai.jupyter
      ];
    };
  };
}
