{
  config,
  lib,
  isDarwin,
  ...
}:
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
    initContent = lib.mkMerge [
      # Homebrew (Apple Silicon): set up PATH/MANPATH/env before compinit so
      # brew binaries and zsh completions are available. Darwin-only.
      (lib.mkIf isDarwin (
        lib.mkOrder 550 ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        ''
      ))
      ''
        if command -v fastfetch >/dev/null 2>&1; then
          fastfetch
        fi
      ''
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
