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
        bridge = config.machine.info.microvm.interfaces.bridge;
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

  microvm.vms."tap-qemu-1" = {
    flake = self;
    updateFlake = "microvm";
  };
  microvm.vms."tap-qemu-2" = {
    flake = self;
    updateFlake = "microvm";
  };
}
