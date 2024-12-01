{ outputs, pkgs, ... }:
{
  imports = [
    # The base configuration of all servers.
    ../base.nix

    # LXC Container configuration
    outputs.nixosModules.proxmox-lxc
  ];
  
  nixpkgs.config.allowUnfree = true;

  services.roon-server = {
    enable = true;
    openFirewall = true;
  };
  # Roon ARC port
  networking.firewall.allowedTCPPorts = [ 55000 ];
}
