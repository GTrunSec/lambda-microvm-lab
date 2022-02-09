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
  # we prefer to use firecracker as containter
  microvm.vms."firecracker-tap" = {
    flake = self;
    updateFlake = "microvm";
  };
  microvm.vms."cloud-hypervisor-tap" = {
    flake = self;
    updateFlake = "microvm";
  };
  microvm.vms."cloud-hypervisor-tap-1" = {
    flake = self;
    updateFlake = "microvm";
  };
}
