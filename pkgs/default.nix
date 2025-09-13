# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
args:
let
  pkgs = args.pkgs or args;
in
{
  # example = pkgs.callPackage ./example { };
  tentrackule = pkgs.callPackage ./tentrackule { };
}
