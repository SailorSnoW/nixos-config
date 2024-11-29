{ modulesPath, ... }:
{
  imports = [
    # Need this import in case of LXC proxmox container setup
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];
  
  boot.isContainer = true;
  # Supress systemd units that don't work because of LXC
  systemd.suppressedSystemUnits = [
    "dev-mqueue.mount"
    "sys-kernel-debug.mount"
    "sys-fs-fuse-connections.mount"
  ];

  # Tailscale can't get access to TUN in lxc container
  services.tailscale.interfaceName = "userspace-networking";
}
