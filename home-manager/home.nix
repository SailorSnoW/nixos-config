{outputs, ...}: {
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
  };

  # You can import other home-manager modules here
  imports = [
    ../modules/home-manager/zsh.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/fastfetch.nix
    ../modules/home-manager/yazi.nix
    ../modules/home-manager/streamrip.nix
  ];

  home.file = {
    "Pictures/fastfetch_logos" = {
      source = ./assets/fastfetch;
      recursive = true;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  programs.lazygit.enable = true;
  programs.git = {
    enable = true;
    userName = "SailorSnoW";
    userEmail = "sailorsnow@pm.me";
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
