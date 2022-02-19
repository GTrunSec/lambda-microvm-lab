{
  config,
  lib,
  pkgs,
  ...
}: {
  services.threatbus-vast = {
    enable = true;
    extraConfigFile = ./vast.yaml;
  };
}
