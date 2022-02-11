{ config, lib, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.interfaces.eth0.ipv4.addresses = [
    {
      address = config.machine.info.ipv4;
      prefixLength = 24;
    }
  ];
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
