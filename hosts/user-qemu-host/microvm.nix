{
  config,
  lib,
  pkgs,
  inputs,
  self,
  ...
}: let
  info = lib.our.getHostInfo ./.;
in {
  imports = [
    inputs.microvm.nixosModules.host
  ];

  microvm = {
    mem = 8192;
    vcpu = 6;
    socket = "${info.name}.sock";
  };

  microvm = {
    hypervisor = info.hypervisor;
    interfaces = [
      {
        type = "user";
        id = "vm-${builtins.substring 0 4 "${info.hypervisor}"}${info.id}";
        mac = "00:02:00:01:01:00";
      }
    ];
    volumes = [
      {
        mountPoint = "/var";
        image = "${info.name}.img";
        size = 2048;
      }
    ];
  };

  # microvm.vms."tap-qemu-1" = {
  #   flake = self;
  #   updateFlake = "microvm";
  # };
}
