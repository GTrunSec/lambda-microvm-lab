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
    vcpu = 6;
    socket = "/tmp/${name}.sock";
  };

  microvm.volumes = [
    {
      mountPoint = "/var";
      image = "/tmp/${name}.img";
      size = 2048;
    }
  ];
  # 10.0.0.5
  microvm.vms."tap_qemu_1" = {
    flake = self;
    updateFlake = "microvm";
  };
  #10.0.0.6
  # microvm.vms."tap_qemu_2" = {
  #   flake = self;
  #   updateFlake = "microvm";
  # };
  # microvm.vms."tap_firecracker_1" = {
  #   flake = self;
  #   updateFlake = "microvm";
  # };
  # 10.0.0.3
  # microvm.vms."tap_cloud-hypervisor_1" = {
  #   flake = self;
  #   updateFlake = "microvm";
  # };
  # #10.0.0.4
  # microvm.vms."tap_cloud-hypervisor_2" = {
  #   flake = self;
  #   updateFlake = "microvm";
  # };
}
