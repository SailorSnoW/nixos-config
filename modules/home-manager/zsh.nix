{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

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
      lg = "lazygit";
      vi = "nvim";
    };
    history = {
      expireDuplicatesFirst = true;
      save = 1000;
    };
    initContent = ''
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
