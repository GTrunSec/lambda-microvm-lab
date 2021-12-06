{ pkgs, self, inputs, system, ... }:

inputs.microvm.lib.runner {
  inherit system;
  hypervisor = "qemu";
  interfaces = [{
    type = "tap";
    id = "template-eth0";
    mac = "00:02:00:01:01:01";
  }];
  volumes = [{
    mountpoint = "/var";
    image = "/tmp/microvm-template-hunting-lab.img";
    size = 256;
  }];
  socket = "control.socket";

  nixosConfig = { pkgs, ... }: {
    networking.hostName = "template";
    users.users.root.password = "";
    imports = [ ];
    environment.systemPackages = [
      pkgs.coreutils
      pkgs.gnugrep
    ];
  };
}
