{ config
, lib
, pkgs
, ...
}:
{
  services.vast = {
    enable = true;
    package = pkgs.vast-release;
    settings = {
      vast = {
        endpoint = "127.0.0.1:42000";
      };
    };
    extraConfigFile = ./vast.yaml.example;
  };
}
