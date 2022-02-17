{
  config,
  lib,
  pkgs,
  ...
}:
let
  info = lib.our.getHostInfo ./.;
in {
  microvm = {
    hypervisor = info.hypervisor;
    interfaces = [
      {
        type = "tap";
        id = "vm-${builtins.substring 0 4 "${info.hypervisor}"}${info.id}";
        mac = "00:02:00:01:01:0${info.mac}";
      }
    ];
  };
}
