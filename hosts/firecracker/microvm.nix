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
    hypervisor = "firecracker";
    interfaces = [
      {
        type = "tap";
        id = "vm-${builtins.substring 0 4 "firecracker"}";
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
