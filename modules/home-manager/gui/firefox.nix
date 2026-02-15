{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    profiles = {
      snow = {
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          vimium
          bitwarden
          startpage-private-search
          firefox-color
          darkreader
          react-devtools
        ];
      };
    };
  };
}
