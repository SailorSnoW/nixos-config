{
  outputs,
  ...
}:
{
  imports = [
    # The base configuration of all servers.
    ../base.nix

    # LXC Container configuration
    outputs.nixosModules.proxmox-lxc

    # Reverse proxy
    outputs.homelabModules.reverseProxy
  ];

  networking.hostName = "hl-front";
  
  # As this most likely face the internet, we secure it
  services.fail2ban.enable = true;
}
