{
  suites,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
in {
  imports = suites."${name}" ++ [./microvm.nix ./network.nix];
}
