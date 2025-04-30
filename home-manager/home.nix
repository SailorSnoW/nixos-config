{
  inputs,
  outputs,
  pkgs,
  lib,
  enableGui,
  ...
}:
{
  # You can import other home-manager modules here
  imports =
    [
      inputs.textfox.homeManagerModules.default

      outputs.homeManagerModules.nushell
      outputs.homeManagerModules.neovim
      outputs.homeManagerModules.fastfetch
      outputs.homeManagerModules.yazi
    ]
    ++ lib.optionals enableGui [
      outputs.homeManagerModules.gui
    ];

  home.packages = with pkgs; [
    cava
    cowsay
  ];

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };
  programs.git = {
    enable = true;
    userName = "SailorSnoW";
    userEmail = "sailorsnow@pm.me";
  };
  programs.eza = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.lazygit.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
