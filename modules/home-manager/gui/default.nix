{
  pkgs,
  lib,
  isDarwin,
  ...
}:
let
  isLinux = !isDarwin;
in
{
  imports = [
    # Cross-platform
    ./ghostty.nix
  ]
  ++ lib.optionals isLinux [
    # Linux only
    ./firefox.nix
    ./linux.nix
    ./rofi.nix
    ./spotify-player.nix
    ./niri
  ];

  home.file = lib.mkIf isLinux {
    "Pictures/wallpapers" = {
      source = ../../../home-manager/assets/wallpapers;
    };
  };

  home.packages =
    with pkgs;
    [
      discord
    ]
    ++ lib.optionals isLinux [
      vesktop
      signal-desktop
      wl-clipboard
      cliphist
    ];

  # GTK (Linux only)
  gtk = lib.mkIf isLinux {
    enable = true;
  };
}
