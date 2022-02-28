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
        type = "bridge";
        bridge = "virbr0";
        id = "vm-${builtins.substring 0 4 "${info.hypervisor}"}${info.id}";
        mac = "00:02:00:01:01:0${info.id}";
      }
    ];
    mem = 8192;
    vcpu = 4;
    socket = "${info.name}.sock";
    volumes = [
      {
        mountPoint = "/var";
        image = "/tmo/${info.name}.img";
        size = 256;
      }
    ];
  };
}
