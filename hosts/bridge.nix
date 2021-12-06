{ pkgs, self, inputs, system, ... }:

inputs.microvm.lib.runner {
  inherit system;
  hypervisor = "qemu";
  interfaces = [{
    type = "bridge,br=virbr0";
    id = "qemu-eth0";
    mac = "00:02:00:01:01:01";
  }];
  volumes = [{
    mountpoint = "/var";
    image = "/tmp/microvm-qemu-hunting-lab.img";
    size = 256;
  }];
  socket = "control.socket";


  nixosConfig = { pkgs, ... }: {
    networking.hostName = "qemu-microvm";
    users.users.root.password = "";
    imports = [
      inputs.zeek2nix.nixosModules.zeek
    ];
    environment.systemPackages = [
      pkgs.coreutils
      pkgs.gnugrep
    ];

    services.zeek = {
      enable = true;
      standalone = true;
      interface = "eth0";
      host = "127.0.0.1";
    };
  };
}