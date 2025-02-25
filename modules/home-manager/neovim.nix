{
  pkgs,
  config,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    defaultEditor = true;
  };

  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink /home/snow/.config/nvim;
    recursive = true;
  };
}
