{
  config,
  lib,
  pkgs,
  ...
}: {
  networking = {
    useDHCP = false;
    defaultGateway = config.machine.info.defaultGateway;
    nameservers = ["1.1.1.1" "8.8.8.8"];
    interfaces."${config.machine.info.bridge}".ipv4.addresses = [
      {
        address = config.machine.info.ipv4;
        prefixLength = 24;
      }
    ];
  };
}
