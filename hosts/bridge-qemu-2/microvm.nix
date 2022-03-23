{
  config,
  lib,
  pkgs,
  ...
}: let
  info = lib.our.getHostInfo ./.;
in {
  microvm = {
    hypervisor = info.hypervisor;
    interfaces = [
      {
        type = "bridge";
        bridge = "enp0s6";
        id = "vm-${builtins.substring 0 4 "${info.hypervisor}"}${info.id}";
        mac = "00:02:00:01:01:0${info.id}";
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

  networking = {
    useDHCP = false;
    defaultGateway = config.machine.info.defaultGateway;
    interfaces."${config.machine.info.bridge}".ipv4.addresses = [
      {
        address = config.machine.info.ipv4;
        prefixLength = 24;
      }
    ];
  };
}
