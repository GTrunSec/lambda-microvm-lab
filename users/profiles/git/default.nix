{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    git-absorb
    pre-commit
  ];
  programs.git = {
    enable = true;
  };
}
