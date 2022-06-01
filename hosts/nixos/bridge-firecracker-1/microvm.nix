{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
in {
  microvm = {
    hypervisor = "firecracker";
    interfaces = [
      {
        type = "tap";
        id = "vm-fc1";
        mac = "00:02:00:01:01:02";
      }
    ];
  };
}
