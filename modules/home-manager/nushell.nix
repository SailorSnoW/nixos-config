{
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        ff = "fastfetch";
        cd = "z";
        ls = "eza";
        lg = "lazygit";
        switch-config = "sudo nixos-rebuild switch --flake";
      };
      extraConfig = ''
                $env.config = {
                  show_banner: false
                  buffer_editor: "nvim"
                }

                let carapace_completer = {|spans|
                 carapace $spans.0 nushell ...$spans | from json
                }

        	sleep 100ms; fastfetch
      '';
    };

    # Auto-completion
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = true;
      };
    };
  };
}
