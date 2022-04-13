{
  config,
  lib,
  pkgs,
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
        id = "vm-nomad";
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
}
