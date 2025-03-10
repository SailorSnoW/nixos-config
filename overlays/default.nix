# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    streamrip = prev.streamrip.overrideAttrs (oldAttrs: rec {
      src = prev.pkgs.fetchFromGitHub {
        owner = "nathom";
        repo = "streamrip";
        rev = "45252651eceeee73b734452ae4e0a9e26de55ca0";
        hash = "sha256-wd5H4eJMIj6SiURkpmwHdyIEMF1cytzBtGtaZgVc/+Q=";
      };
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
