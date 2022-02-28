{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.interfaces.eth0.ipv4.addresses = [
    {
      address = config.machine.info.ipv4;
      prefixLength = 24;
    }
  ];
}
