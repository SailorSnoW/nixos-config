{
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        ff = "fastfetch";
        cd = "z";
        ls = "eza";
        update-server = "sudo nixos-rebuild switch --flake .#server";
      };
    };

    # Auto-completion
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
