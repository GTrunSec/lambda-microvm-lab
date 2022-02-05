{ config
, lib
, pkgs
, ...
}:
{
  microvm.interfaces = [
    {
      type = "tap";
      id = "vm-${builtins.substring 0 4 "firecracker"}";
      mac = "00:02:00:01:01:01";
    }
  ];
}
