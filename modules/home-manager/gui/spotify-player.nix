{ pkgs, ... }:
{
  stylix.targets.spotify-player.enable = false;

  programs.spotify-player = {
    enable = true;
  };
}
