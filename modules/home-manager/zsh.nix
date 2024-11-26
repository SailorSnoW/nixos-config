{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    shellAliases = {
      cd = "z";
      ls = "eza";
      ll = "eza -l";
      update-server = "sudo nixos-rebuild switch --flake .#server";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
