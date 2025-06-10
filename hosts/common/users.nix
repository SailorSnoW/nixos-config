{ pkgs, ... }:
{
  users.users = {
    snow = {
      isNormalUser = true;
      shell = pkgs.zsh;
    };
  };
}
