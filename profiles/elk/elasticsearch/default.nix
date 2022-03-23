{
  config,
  lib,
  pkgs,
  ...
}: {
  services.elasticsearch = {
    enable = true;
  };
}
