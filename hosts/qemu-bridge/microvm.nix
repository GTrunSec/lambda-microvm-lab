{ config
, lib
, pkgs
, ...
}:
let
  name = builtins.baseNameOf ./.;
in
{
  microvm = {
    hypervisor = "${name}";
    interfaces = [
      {
        type = "bridge,br=virbr0";
        id = "vm-${builtins.substring 0 4 "${name}"}";
        mac = "00:02:00:01:01:01";
      }
    ];
    mem = 8192;
    vcpu = 4;
    socket = "/tmp/${name}.sock";
    volumes = [
      {
        mountPoint = "/var";
        image = "/tmp/${name}.img";
        size = 256;
      }
    ];
  };
}
