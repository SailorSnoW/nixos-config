{

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };

  # Time sync
  services.ntp = {
    enable = true;
    servers = [ "pool.ntp.org" ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "fr";
  services.xserver.xkb.variant = "mac";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
}
