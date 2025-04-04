# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  fastfetch = import ./fastfetch.nix;
  neovim = import ./neovim.nix;
  yazi = import ./yazi.nix;
  zsh = import ./zsh.nix;
  nushell = import ./nushell.nix;
  gitui = import ./gitui.nix;
  streamrip = import ./streamrip.nix;
}
