{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.vast-client = {
    enable = true;
    settings.vast.endpoint = config.machine.services.vast-client.endpoint;
    package = pkgs.vast-release;
    integrations.broker = config.machine.services.vast-client.broker;
    integrations.pcap.enable = config.machine.services.vast-client.pcap.enable;
    integrations.pcap.interface =
      config.machine.services.vast-client.pcap.interface;
  };
}
