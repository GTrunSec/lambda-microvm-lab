{
  suites,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
in {
  imports = suites."${name}" ++ [./microvm.nix ../tap-qemu-host/network.nix];
}
