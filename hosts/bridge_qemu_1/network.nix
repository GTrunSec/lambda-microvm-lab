{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking = {
    #interfaces.eth0.useDHCP = true;
    # interfaces.eth0.useDHCP = true;
    interfaces.eth0.ipv4.addresses = [
      {
        address = config.machine.info.ipv4;
        prefixLength = 24;
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [22];
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
