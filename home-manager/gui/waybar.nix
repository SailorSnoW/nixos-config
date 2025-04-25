{ config, ... }:
{
  stylix.targets.waybar.enable = false;
  programs.waybar.enable = true;
  programs.waybar.settings = [
    {
      layer = "top";
      position = "top";
      margin = "5px 72px";
      height = 32;
      spacing = 8;

      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-right = [
        "pulseaudio"
        "network"
        "battery"
        "cpu"
        "memory"
        "clock"
      ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = false;
        format = "{icon}";
        format-icons = {
          "1:web" = "";
          "2:code" = "";
          "3:term" = "";
          "4:work" = "";
          "5:music" = "";
          urgent = "";
          focused = "";
          default = "";
        };
      };

      "hyprland/window" = {
        rewrite = {
          "(.*) - Mozilla Firefox" = "$1";
        };
        separate-outputs = true;
        max-length = 36;
        icon = true;
        icon-size = 16;
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
      };

      cpu = {
        format = "{usage}% ";
      };

      memory = {
        format = "{}% ";
      };

      network = {
        format-wifi = "Connected ({signalStrength}%) ";
        format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
        format-disconnected = "Disconnected ⚠";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      pulseaudio = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted = "";
        format-icons = {
          headphones = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
      };
    }
  ];

  programs.waybar.style = with config.lib.stylix.colors.withHashtag; ''
    * {
      border: none;
      border-radius: 12px;
      font-family: "FiraCode Nerd Font";
      font-size: 15px;
    }

    window#waybar {
      background: transparent;
    }

    window#waybar.hidden {
      opacity: 0.2;
    }

    #window {
      padding-left: 12px;
      padding-right: 12px;
      border-radius: 12px;
      transition: none;
      color: ${base05};
      background: ${base01};
    }

    #workspaces {
      padding-left: 12px;
      padding-right: 12px;
      font-size: 4px;
      border-radius: 12px;
      background: ${base01};
      transition: none;
    }

    #workspaces button {
      color: ${base0C};
      background: transparent;
      font-size: 16px;
      border-radius: 2px;
    }

    #workspaces button.active {
      color: ${base0A};
      border-bottom: 2px solid ${base0C};
    }

    #workspaces button:hover {
      transition: none;
      box-shadow: inherit;
      text-shadow: inherit;
      color: ${base07};
    }

    #network {
      padding-left: 12px;
      padding-right: 12px;
      border-radius: 12px;
      transition: none;
      color: ${base05};
      background: ${base01};
    }

    #pulseaudio {
      padding-left: 12px;
      padding-right: 12px;
      border-radius: 12px;
      transition: none;
      color: ${base05};
      background: ${base01};
    }

    #battery {
      padding-left: 12px;
      padding-right: 12px;
      border-radius: 12px;
      transition: none;
      color: ${base05};
      background: ${base01};
    }

    #battery.charging,
    #battery.plugged {
      color: #161320;
      background-color: #B5E8E0;
    }

    #battery.critical:not(.charging) {
      background-color: #B5E8E0;
      color: #161320;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    @keyframes blink {
      to {
        background-color: #BF616A;
        color: #B5E8E0;
      }
    }

    #backlight {
      padding-left: 12px;
      padding-right: 12px;
      border-radius: 12px;
      transition: none;
      color: ${base0C};
      background: ${base01};
    }

    #clock {
      padding-left: 12px;
      padding-right: 12px;
      border-radius: 12px;
      transition: none;
      color: #161320;
      background: ${base09};
      /* background: #1A1826; */
    }

    #memory {
      padding-left: 12px;
      padding-right: 12px;
      border-radius: 12px;
      transition: none;
      color: #161320;
      background: ${base08};
    }

    #cpu {
      padding-left: 12px;
      padding-right: 12px;
      border-radius: 12px;
      transition: none;
      color: #161320;
      background: ${base08};
    }
  '';
}
