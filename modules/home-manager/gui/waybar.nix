{
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    settings = {
      waybar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        margin-left = 14;
        margin-right = 14;
        margin-top = 2;
        modules-left = [
          "custom/nixos"
          "niri/workspaces"
          "niri/window"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "clock"
        ];

        "custom/nixos" = {
          format = "";
          tooltip = true;
          tooltip-format = "btw";
        };

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            "browser" = "";
            "chat" = "<b></b>";

            "default" = "";
          };
        };

        "niri/window" = {
          format = "{}";
          icon = true;
          max-length = 24;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%  {format_source}";
          format-bluetooth-muted = "{icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "󰖩 {essid}";
          format-ethernet = "{ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected ⚠";
          # on-click = "sh ~/scripts/rofi-wifi-menu/rofi-wifi-menu.sh";
        };

        cpu = {
          format = " {usage}%";
          tooltip = true;
        };

        memory = {
          format = " {}%";
          tooltip = true;
        };

        temperature = {
          interval = 10;
          critical-threshold = 100;
          format-critical = " {temperatureC}";
          format = " {temperatureC}°C";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-full = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };

    style = ''
      * {
        font-family: "FiraCode Nerd Font Mono";
        font-weight: bold;
        font-size: 14px;
      }

      window#waybar {
        background: none;
        border: none;
      }

      #workspaces {
        margin-left: 8px;
      }

      #workspaces button {
        padding: 0 3px;
        box-shadow: none;
        background-color: transparent;
      }


      #workspaces button.focused {
        box-shadow: none;
        color: #f6c177;
        font-weight: 900;
      }

      .modules-left,
      .modules-right {
        border: 2.5px solid rgba(196, 167, 231, 0.2);
        border-radius: 12px;
        margin: 4px 20px;
        padding: 2px 5px;
        background: rgba(57, 53, 82, 0.75);
      }

      .modules-center {
        border: none;
        background: none;
      }

      #custom-nixos {
        font-size: 18px;
        padding-left: 10px;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #power-profiles-daemon,
      #language,
      #mpd {
        padding: 0 10px;
        border-radius: 15px;
      }

      #clock:hover,
      #battery:hover,
      #cpu:hover,
      #memory:hover,
      #disk:hover,
      #temperature:hover,
      #backlight:hover,
      #network:hover,
      #pulseaudio:hover,
      #wireplumber:hover,
      #custom-media:hover,
      #tray:hover,
      #mode:hover,
      #idle_inhibitor:hover,
      #scratchpad:hover,
      #power-profiles-daemon:hover,
      #language:hover,
      #mpd:hover {
        background: rgba(26, 27, 38, 0.9);
      }
    '';
  };
}
