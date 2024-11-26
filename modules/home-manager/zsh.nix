{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      update-server = "sudo nixos-rebuild switch --flake .#server";
    };
  };
}
