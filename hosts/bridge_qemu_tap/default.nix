{
  suites,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
in {
  imports = suites."${name}" ++ [./microvm.nix ../tap_qemu_host/network.nix];
}
