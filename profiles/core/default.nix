{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./nix.nix];

  environment.systemPackages = [pkgs.git];
}
