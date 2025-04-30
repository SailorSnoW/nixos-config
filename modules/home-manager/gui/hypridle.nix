{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock-cmd = "uwsm app -- hyprlock";
        ignore_dbus_inhibit = false;
        after-sleep-cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 60;
          on-timeout = "brightnessctl -sd kbd_backlight set 0";
          on-resume = "brightnessctl -rd kbd_backlight";
        }
        {
          timeout = 600;
          on-timeout = "uwsm app -- hyprlock";
        }
        {
          timeout = 630;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
