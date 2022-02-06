{ config
, lib
, pkgs
, ...
}:
let
  name = builtins.baseNameOf ./.;
  hypervisor = builtins.head (builtins.split "-" name);
in
{
  microvm = {
    inherit hypervisor;
    interfaces = [
      {
        type = "bridge";
        bridge = "virbr0";
        id = "vm-${builtins.substring 0 4 "${name}"}";
        mac = "00:02:00:01:01:01";
      }
    ];
    mem = 8192;
    vcpu = 4;
    socket = "${name}.sock";
    volumes = [
      {
        mountPoint = "/var";
        image = "${name}.img";
        size = 256;
      }
    ];
  };
}
