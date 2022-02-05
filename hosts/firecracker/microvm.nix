{ config, lib, pkgs, ... }:

{
  microvm.interfaces = [ {
    type = "tap";
    id = "vm-${builtins.substring 0 4 "firecracker"}";
    mac = "00:02:00:01:01:01";
  } ];
  networking.interfaces.eth0.useDHCP = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
