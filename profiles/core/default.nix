{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./nix.nix ./shell.nix ../cachix];

  environment.systemPackages = [pkgs.git];

  system.stateVersion = "22.05";
}
