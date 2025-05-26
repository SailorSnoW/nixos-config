{
  programs.niri.settings = {
    input = {
      keyboard = {
        xkb = {
          layout = "fr";
          variant = "mac";
          options = "eurosign:e,caps:escape";
        };

        repeat-delay = 300;
      };

      touchpad = {
        tap = false;
        dwt = true;
        natural-scroll = false;
        scroll-factor = 0.3;
      };

      focus-follows-mouse.enable = true;
    };
    cursor = {
      hide-when-typing = true;
    };
    hotkey-overlay = {
      skip-at-startup = true;
    };
  };
}
