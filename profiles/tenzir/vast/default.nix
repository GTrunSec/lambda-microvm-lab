{
  config,
  lib,
  pkgs,
  ...
}: {
  services.vast = {
    enable = true;
    package = pkgs.vast-release;
    settings = {
      vast = {
        endpoint = config.machine.services.vast.endpoint;
      };
    };
    extraConfigFile = ./vast.yaml.example;
  };
}
