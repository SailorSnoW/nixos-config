# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  fastfetch = import ./fastfetch.nix;
  neovim = import ./neovim;
  yazi = import ./yazi.nix;
  zsh = import ./zsh.nix;
  streamrip = import ./streamrip.nix;
  spotify-player = import ./spotify-player.nix;
  btop = import ./btop.nix;

  # Related Desktop apps requiring DestopManager and session
  gui = import ./gui;
}
