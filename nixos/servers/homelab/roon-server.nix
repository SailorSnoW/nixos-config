{ outputs, ... }:
{
  imports = [
    # The base configuration of all servers.
    ../base.nix

    # LXC Container configuration
    outputs.nixosModules.proxmox-lxc
  ];
  
  networking.hostName = "hl-roon-server";

  nixpkgs.config.allowUnfree = true;
  services.roon-server = {
    enable = true;
    openFirewall = true;
  };
  # Roon ARC port
  networking.firewall.allowedTCPPorts = [ 55000 ];
}
