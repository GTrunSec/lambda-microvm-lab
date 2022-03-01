{
  config,
  lib,
  pkgs,
  ...
}: let
  info = lib.our.getHostInfo ./.;
in {
  microvm = {
    hypervisor = info.hypervisor;
    interfaces = [
      {
        type = "tap";
        id = "vm-t${builtins.substring 0 3 "${info.hypervisor}"}${info.id}";
        mac = "00:02:00:01:01:2${info.mac}";
      }
    ];
  };
}
