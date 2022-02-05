{ channels
, inputs
, system ? channels.nixpkgs.stdenv.hostPlatform.system
, ...
}:
let
  pkgs = channels.nixpkgs;
in
inputs.microvm.lib.runner {
  inherit system;
  hypervisor = "qemu";
  interfaces = [
    {
      type = "bridge,br=virbr0";
      id = "qemu-eth0";
      mac = "00:02:00:01:01:01";
    }
  ];
  mem = 8000;
  volumes = [
    {
      mountpoint = "/var";
      image = "/tmp/microvm-qemu-hunting-lab.img";
      size = 256;
    }
  ];
  socket = "control.socket";
  nixosConfig = { };
}
