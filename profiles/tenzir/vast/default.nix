{ config
, lib
, pkgs
, ...
}:
{
  services.vast = {
    enable = false;
    # integrations.broker = true;
    package = pkgs.vast-release;
    # integrations.broker = true;
    extraConfigFile = ./vast.yaml.example;
  };
}
