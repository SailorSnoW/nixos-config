# Linux-only GUI configurations (Stylix, Textfox, etc.)
# This module is only imported on Linux systems
{ ... }:
{
  # Stylix Firefox theme
  stylix.targets.firefox.profileNames = [ "snow" ];

  # Textfox theme
  textfox = {
    enable = true;
    profile = "snow";
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
