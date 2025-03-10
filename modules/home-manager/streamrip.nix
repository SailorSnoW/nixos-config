{pkgs, ...}: {
  home.packages = with pkgs; [
    streamrip
  ];
}
