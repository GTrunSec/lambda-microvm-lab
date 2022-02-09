{ config
, lib
, pkgs
, inputs
, self
, ...
}:
let
  name = builtins.baseNameOf ./.;
in
{
  imports = [
    inputs.microvm.nixosModules.host
  ];

  microvm = {
    mem = 8192;
    vcpu = 4;
    socket = "/tmp/${name}.sock";
  };
  microvm.volumes = [
    {
      mountPoint = "/var";
      image = "/tmp/${name}.img";
      size = 32;
    }
  ];
  microvm.vms."firecracker-tap" = {
    flake = self;
    updateFlake = "microvm";
  };
}
