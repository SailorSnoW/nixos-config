{ ... }:
{
  imports = [
    ../common
  ];

  wsl = {
    enable = true;
    defaultUser = "snow";
  };

  networking.hostName = "snow-wsl";

  nixpkgs.hostPlatform = "x86_64-linux";

  # Allows running foreign binaries (VSCode remote server, rustup, ...)
  programs.nix-ld.enable = true;

  system.stateVersion = "25.11";
}
