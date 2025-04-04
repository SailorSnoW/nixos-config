{ outputs, ... }:
{
  imports = [
    # The base configuration of all servers.
    ../base.nix

    # LXC Container configuration
    outputs.nixosModules.proxmox-lxc

    # Tentrackule bot service
    outputs.nixosModules.tentrackule
  ];

  networking.hostName = "tentrackule-host";

  services.tentrackule = {
    enable = true;
    riotApiKey = "";
    discordToken = "";
  };
}
