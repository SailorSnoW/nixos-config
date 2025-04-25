{
  pkgs,
  config,
  ...
}:
{
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
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
    ];
  };

  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/nvim;
  };
}
