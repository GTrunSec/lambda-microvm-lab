{
  config,
  lib,
  pkgs,
  self,
  inputs,
  ...
}: let
  info = lib.our.getHostInfo ./.;
in {
  imports = [
    inputs.microvm.nixosModules.host
  ];

  microvm = {
    hypervisor = info.hypervisor;
    interfaces = [
      {
        type = "bridge";
        bridge = "virbr0";
        id = "vm-${builtins.substring 0 4 "${info.hypervisor}"}${info.id}";
        mac = "00:02:00:01:01:11";
      }
    ];
    mem = 8192;
    vcpu = 4;
    socket = "${info.name}.sock";
    volumes = [
      {
        mountPoint = "/var";
        image = "${info.name}.img";
        size = 1024;
      }
    ];
  };

  microvm.vms."tap_qemu_1" = {
    flake = self;
    updateFlake = "microvm";
  };
  # microvm.vms."bridge_qemu_2" = {
  #   flake = self;
  #   updateFlake = "microvm";
  # };
}
