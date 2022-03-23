{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.services.vast = {
    after = ["microvm-tap-interfaces@tap-qemu-1.service"];
  };

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
