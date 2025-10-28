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

  stylix.targets.firefox.profileNames = [ "snow" ];

  textfox = {
    enable = true;
    profile = "snow";
    # https://github.com/adriankarlen/textfox/pull/131
    useLegacyExtensions = false;
    config = {
      border = {
        color = "#393552";
        width = "2px";
        transition = "0.3s ease";
        radius = "12px";
      };
      displayWindowControls = true;
      displayNavButtons = true;
      displayUrlbarIcons = true;
      displaySidebarTools = false;
      displayTitles = false;
      font = {
        family = "FiraCode Nerd Font Ret";
        size = "15px";
      };
    };

  };
}
