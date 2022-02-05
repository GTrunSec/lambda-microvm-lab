{ config
, lib
, pkgs
, ...
}:
{
  services.vast = {
    enable = true;
    package = pkgs.vast-release;
    extraConfigFile = ./vast.yaml.example;
  };
}
