{ pkgs, ... }:
{
  imports = [
    ./binds.nix
    ./rules.nix
    ./layout.nix
    ./inputs.nix
  ];

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gnome
        pkgs.gnome-keyring
      ];
      configPackages = [ pkgs.niri ];
    };
  };

  home.packages = with pkgs; [
    swww
    wev
  ];

  programs.niri.settings = {
    spawn-at-startup = [
      {
        command = [ "waybar" ];
      }
      {
        command = [ "vesktop" ];
      }
      {
        command = [
          "swww-daemon"
        ];
      }
    ];

    screenshot-path = "null";

    workspaces = {
      "1-chat" = {
        name = "chat";
      };
      "2-browser" = {
        name = "browser";
      };
    };

    environment = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      MOZ_ENABLE_WAYLAND = "1";
      EDITOR = "nvim";
    };

    debug = {
      # Required to prevent black screen on starting niri with Asahi
      "render-drm-device" = "/dev/dri/renderD128";
    };
  };
}
