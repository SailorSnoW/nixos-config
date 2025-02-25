{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # LSPs
      nixd
      lua-language-server
      gcc
      rust-analyzer
      go
      php
      # Formatters
      alejandra
      stylua
      csharpier
      prettierd
      shfmt

      # Others
      ripgrep
      fd
      lazygit
    ];
  };

  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink /home/snow/nixos-config/dotfiles/nvim;
  };
}
