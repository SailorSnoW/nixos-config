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
    
    # OCI Containers configurations
    outputs.ociContainers.speedtestTracker
    outputs.ociContainers.wallos
  ];
}
