{ config, lib, pkgs, self, ... }:

{
  microvm = {
    mem = 8192;
    vcpu = 4;
    socket = "./microvm.sock";
  };

  microvm.volumes = [ {
    mountPoint = "/var";
    image = "runners/var.img";
    size = 32;
  } ];

  microvm.vms."firecracker" = {
    flake = self;
    updateFlake = "microvm";
  };
}
