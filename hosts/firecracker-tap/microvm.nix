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
        type = "tap";
        id = "vm-${builtins.substring 0 4 "firecracker"}";
        mac = "00:02:00:01:01:01";
      }
    ];
  };
}
