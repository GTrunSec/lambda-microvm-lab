{
  config,
  lib,
  pkgs,
  ...
}: {
  services.threatbus = {
    enable = true;
    extraConfigFile = ./conf/threatbus.yaml;
  };
}
