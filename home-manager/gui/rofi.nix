{
  config,
  pkgs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      show-icons = true;
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          border-radius = 10;
          width = 600;
          spacing = 8;
        };

        "window" = {
          border = 2;
          padding = mkLiteral "16px";
        };

        "#mainbox" = {
          children = map mkLiteral [
            "inputbar"
            "message"
            "listview"
          ];
          spacing = 12;
        };

        "#inputbar" = {
          children = map mkLiteral [
            "prompt"
            "entry"
          ];
          padding = mkLiteral "6px 10px";
          border-radius = 6;
        };

        "#textbox-prompt-colon" = {
          expand = false;
          str = ":";
          margin = mkLiteral "0px 0.3em 0em 0em";
        };

        "entry" = {
          padding = mkLiteral "5px 8px";
        };

        "#listview" = {
          layout = mkLiteral "vertical";
          dynamic = true;
          scrollbar = false;
          fixed-height = true;
          lines = 6;
          spacing = 8;
        };

        "element" = {
          padding = mkLiteral "8px 10px";
          border-radius = 6;
        };
      };
  };
}
