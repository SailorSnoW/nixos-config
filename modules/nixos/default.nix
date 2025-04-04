# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  proxmox-lxc = import ./proxmox-lxc.nix;
  netdata = import ./netdata.nix;

  # Minecraft servers
  mc-server-pixelmon = import ./minecraft-server-pixelmon.nix;
  mc-server-cobblemon-sa = import ./minecraft-server-cobblemon-sa.nix;

  tentrackule = import ./tentrackule.nix;
}
