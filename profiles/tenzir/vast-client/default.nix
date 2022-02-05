{ config, lib, pkgs, ... }:

{
  vast-client = {
    enable = true;
    settings.vast.endpoint = "192.168.1.5:42000";
    package = pkgs.vast-release;
    integrations.pcap.enable = true;
    integrations.pcap.interface = "eth0";
  };
}
