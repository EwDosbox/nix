{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "sway/workspaces"
          "sway/window"
        ];

        "sway/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          format = "{icon}";
          "format-icons" = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
        };

        "sway/window" = {
          format = "{}";
          "max-length" = 120;
        };

        modules-center = [
          "network"
        ];

        network = {
          "format-disabled" = "Disabled";
          "format-wifi" = " D: {bandwidthDownBits:>} U: {bandwidthUpBits:>}";
          "tooltip-format-wifi" = "ESSID: {essid}";
          "format-ethernet" = "D: {bandwidthDownBits:>} U: {bandwidthUpBits:>}";
          "tooltip-format-ethernet" = "{ifname}: {ipaddr}/{cidr}";
          "format-disconnected" = "Disconnected";
          "on-click" = "footclient -T waybar_nmtui -e nmtui";
          interval = 2;
        };

        modules-right = [
          "privacy"
          "group/resources"
          "memory"
          "wireplumber"
          "battery"
          "backlight"
          "bluetooth"
          "tray"
          "clock"
          "custom/power"
          "custom/reboot"
          "custom/lock"
        ];

        privacy = {
          "icon-spacing" = 4;
          "icon-size" = 18;
          "transition-duration" = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              "tooltip-icon-size" = 24;
            }
            {
              type = "audio-out";
              tooltip = true;
              "tooltip-icon-size" = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              "tooltip-icon-size" = 24;
            }
          ];
        };

        "group/resources" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 500;
            "children-class" = "resources-drawer";
            "transition-left-to-right" = true;
            "click-to-reveal" = true;
          };
          modules = [
            "cpu"
            "temperature"
            "disk"
          ];
        };

        cpu = {
          interval = 5;
          format = "CPU: {usage}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        temperature = {
          "critical-threshold" = 80;
          "format-critical" = "TEMP: {temperatureC}°C";
          format = "TEMP: {temperatureC}°C";
          "tooltip-format" = "TEMP: s-tui\n {temperatureC}° Celsius\n{temperatureF}° Fahrenheit\n{temperatureK}° Kelvin";
          "on-click" = "footclient -T waybar_s-tui -e s-tui";
        };

        disk = {
          interval = 600;
          format = "DISK: {percentage_used}%";
          path = "/";
          "on-click" = "footclient -T waybar_dua -e dua i /";
          "tooltip-format" = "DISK: dua\nTotal: {total}\n Used: {used} ({percentage_used}%)\n Free: {free} ({percentage_free}%)";
        };

        memory = {
          interval = 5;
          format = "RAM: {}%";
          "on-click" = "footclient -T waybar_btm -e btm";
          states = {
            warning = 70;
            critical = 90;
          };
          "tooltip-format" = "RAM: btm\n   Memory: {total} GiB\n   In use: {used} GiB ({percentage}%)\nAvailable: {avail} GiB\n     Swap: {swapTotal} GiB\n   In use: {swapUsed} GiB ({swapPercentage}%)\nAvailable: {swapAvail} GiB";
        };

        wireplumber = {
          format = "VOL: {volume}%";
          "format-muted" = "VOL: muted";
          "on-click" = "pavucontrol";
          "on-click-right" = "pamixer --toggle-mute";
          "tooltip-format" = "VOL: pavucontrol\nR: Toggle mute\nNode: {node_name}";
        };

        battery = {
          states = {
            warning = 20;
            critical = 10;
          };
          format = "BAT: {capacity}%";
          "format-charging" = "BAT: {capacity}%";
          "format-plugged" = "BAT: {capacity}%";
          "format-full" = "BAT: {capacity}%";
          "format-icons" = ["" "" "" "" ""];
          "tooltip-format" = "BAT: battop\n{timeTo}";
          "on-click" = "footclient -T waybar_battop -e battop";
        };

        backlight = {
          format = "{icon} {percent}%";
          "format-icons" = ["󰄰" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
          "tooltip-format" = "Backlight (Scroll): {percent:}%";
          "on-scroll-down" = "brightnessctl -c backlight set 5%-";
          "on-scroll-up" = "brightnessctl -c backlight set +5%";
        };

        bluetooth = {
          format = "BT: {status}:{num_connections}";
          "format-on" = "On";
          "format-off" = "Off";
          "format-disabled" = "";
          "format-icons" = ["󰤾" "󰤿" "󰥀" "󰥁" "󰥂" "󰥃" "󰥄" "󰥅" "󰥆" "󰥈"];
          "tooltip-format" = "L󰍽: bluetui\nR󰍽: bluetoothctl power on/off\nController: {controller_alias}\t{controller_address}\nConnected devices: {num_connections}";
          "tooltip-format-connected" = "L󰍽: bluetui\nR󰍽: bluetoothctl power on/off\nController: {controller_alias}\t{controller_address}\nConnected devices: {num_connections}\nDevice---------------Address------------Battery\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias:<20} {device_address:<18}";
          "tooltip-format-enumerate-connected-battery" = "{device_alias:<20.20} {device_address:<18.18} {icon} {device_battery_percentage}%";
          "on-click" = "footclient -T waybar_bluetui -e bluetui";
          "on-click-right" = "~/.config/sway/scripts/bluetooth_toggle.sh";
        };

        tray = {
          "icon-size" = 16;
          spacing = 10;
        };

        clock = {
          format = "{:%H:%M}";
          "on-click" = "footclient -T waybar_calcurse -e calcurse";
          "tooltip-format" = " {:%A %m/%d}\n\n<tt><small>{calendar}</small></tt>";
          calendar = {
            "on-scroll" = 1;
            format = {
              months = "<span color='#F5BF3B'><b>{}</b></span>";
              days = "<span color='#ffffff'><b>{}</b></span>";
              weeks = "<span color='#6ca0a3'><b>W{}</b></span>";
              weekdays = "<span color='#E2231A'><b>{}</b></span>";
              today = "<span color='#F5BF3B'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        "custom/power" = {
          format = "OFF";
          "on-click" = "systemctl poweroff";
          "tooltip-format" = "Shutdown";
        };
        "custom/reboot" = {
          format = "REB";
          "on-click" = "systemctl reboot";
          "tooltip-format" = "Reboot";
        };
        "custom/lock" = {
          format = "LOC";
          "on-click" = "gtklock";
          "tooltip-format" = "Lock";
        };
      }
    ];
    style = builtins.readFile ./../dots/waybar.css;
  };
}
