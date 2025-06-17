{
  programs.fastfetch = {
    enable = true;
  };

  home.file = {
    ".config/fastfetch".source = ../../dotfiles/fastfetch;
    "Pictures/fastfetch_logos" = {
      source = ../../home-manager/assets/fastfetch;
      recursive = true;
    };
  };
}
