{ pkgs, ... }:
{
  home.packages = with pkgs; [
    beatprints
  ];

  stylix.targets.spotify-player.enable = false;

  programs.spotify-player = {
    enable = true;
    settings = {
      cover_img_scale = 3;
    };
  };
}
