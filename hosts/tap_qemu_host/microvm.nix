{
  config,
  lib,
  pkgs,
  inputs,
  self,
  ...
}: let
  name = builtins.baseNameOf ./.;
in {
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
  # 10.0.0.2
  microvm.vms."tap_firecracker_1" = {
    flake = self;
    updateFlake = "microvm";
  };
  # 10.0.0.3
  microvm.vms."tap_cloud-hypervisor_1" = {
    flake = self;
    updateFlake = "microvm";
  };
  #10.0.0.4
  microvm.vms."tap_cloud-hypervisor_2" = {
    flake = self;
    updateFlake = "microvm";
  };
}
