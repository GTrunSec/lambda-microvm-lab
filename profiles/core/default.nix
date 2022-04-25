{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./nix.nix ./shell.nix];

  environment.systemPackages = [pkgs.git];
}
