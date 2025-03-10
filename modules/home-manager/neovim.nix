{
  pkgs,
  config,
  ...
}:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # LSPs
      nixd
      lua-language-server
      gcc
      go
      php
      # Formatters
      nixfmt-rfc-style
      stylua
      prettierd
      shfmt

      # Others
      ripgrep
      fd
      lazygit
    ];
  };

  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/nvim;
  };
}
