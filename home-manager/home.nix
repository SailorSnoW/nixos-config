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

      outputs.homeManagerModules.zsh
      outputs.homeManagerModules.neovim
      outputs.homeManagerModules.fastfetch
      outputs.homeManagerModules.yazi
      outputs.homeManagerModules.btop
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
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
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
  programs.lazygit.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
