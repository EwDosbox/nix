{pkgs, ...}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "Courier Prime-Regular:size=11";
        line-height = 14;
        letter-spacing = 0;
        pad = "16x16";
      };

      bell = {
        urgent = "no";
        notify = "no";
      };

      scrollback = {
        lines = 5000;
        multiplier = 3.0;
      };

      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
      };

      cursor = {
        style = "block";
        blink = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
        alternate-scroll-mode = "yes";
      };

      colors-dark = {
        alpha = "0.85";
        foreground = "ffffff";
        background = "000000";

        regular0 = "121212"; # Dark Black
        regular1 = "E2231A"; # Lenovo Red
        regular2 = "7f9f7f"; # Muted Green
        regular3 = "F5BF3B"; # Solar Yellow
        regular4 = "6ca0a3"; # Ice Blue
        regular5 = "69448E"; # Electric Purple
        regular6 = "93e0e3"; # Muted Cyan
        regular7 = "888888"; # Functional Gray

        bright0 = "666666"; # Bright gray for comments
        bright1 = "FF332A"; # Glowing Neon Red
        bright2 = "bfebbf"; # Bright Green
        bright3 = "F5BF3B"; # Bright Solar Power
        bright4 = "8cd0d3"; # Bright Blue
        bright5 = "8A5BB8"; # Bright Electric Purple
        bright6 = "b3ffff"; # Bright Cyan
        bright7 = "ffffff"; # Pure White

        selection-foreground = "ffffff";
        selection-background = "E2231A";
        urls = "F5BF3B";
      };

      csd = {
        size = 0;
      };

      key-bindings = {
        clipboard-copy = "Control+Shift+c XF86Copy";
        clipboard-paste = "Control+Shift+v XF86Paste";
        search-start = "Control+Shift+r";
        font-increase = "Control+plus Control+equal";
        font-decrease = "Control+minus";
        font-reset = "Control+0";
        spawn-terminal = "Control+Shift+n";
        unicode-input = "none";
        show-urls-launch = "Control+Shift+u";
      };

      search-bindings = {
        cancel = "Control+g Control+c Escape";
        commit = "Return";
        find-prev = "Control+r";
        find-next = "Control+s";
      };

      url-bindings = {
        cancel = "Control+g Control+c Control+d Escape";
        toggle-url-visible = "t";
      };

      mouse-bindings = {
        primary-paste = "BTN_MIDDLE";
        select-begin = "BTN_LEFT";
      };
    };
  };
}
