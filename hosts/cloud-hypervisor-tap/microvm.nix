{ config
, lib
, pkgs
, ...
}:
let
  name = builtins.baseNameOf ./.;
  hypervisor = (builtins.head (builtins.split "-" name)) + "-hypervisor";
in
{
  microvm = {
    inherit hypervisor;
    interfaces = [
      {
        type = "tap";
        id = "vm-${builtins.substring 0 4 "${hypervisor}"}";
        mac = "00:02:00:01:01:03";
      }
    ];
  };
}
