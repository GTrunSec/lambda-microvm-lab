{ config
, lib
, pkgs
, ...
}:
{
  networking = { interfaces.eth0.useDHCP = true; };
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
