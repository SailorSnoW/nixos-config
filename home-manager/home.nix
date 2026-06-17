{
  inputs,
  outputs,
  pkgs,
  lib,
  enableGui,
  isDarwin,
  config,
  ...
}:
let
  isLinux = !isDarwin;
in
{
  # You can import other home-manager modules here
  imports = [
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.neovim
    outputs.homeManagerModules.fastfetch
    outputs.homeManagerModules.yazi
    outputs.homeManagerModules.btop
  ]
  ++ lib.optionals isLinux [
    # Textfox (Linux only)
    inputs.textfox.homeManagerModules.default
  ]
  ++ lib.optionals enableGui [
    outputs.homeManagerModules.gui
  ];

  home.packages = with pkgs; [
    cowsay
    cargo
    kubectl
    kubernetes-helm
    k9s
    kind
    ncdu
    sops
    age
    devenv
    lazydocker
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  programs.git = {
    enable = true;
    signing.format = null;
    settings.user = {
      name = "SailorSnoW";
      email = "sailorsnow@pm.me";
    };
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
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      extraOptions = {
        AddKeysToAgent = "yes";
      }
      // lib.optionalAttrs isDarwin {
        UseKeychain = "yes";
      };
    };
  };

  # Nicely reload system units when changing configs (Linux only)
  systemd.user.startServices = lib.mkIf isLinux "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
