{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "direnv"
      ];
      theme = "robbyrussell";
    };
    shellAliases = {
      ff = "fastfetch";
      cd = "z";
      ls = "eza";
      update-server = "sudo nixos-rebuild switch --flake .#server";
    };
    history = {
      expireDuplicatesFirst = true;
      save = 1000;
    };
    initExtra = ''
      if command -v fastfetch >/dev/null 2>&1; then
        fastfetch
      fi
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
