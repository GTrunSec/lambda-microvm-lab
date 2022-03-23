{
  config,
  lib,
  pkgs,
  ...
}: {
  services.elasticsearch = {
    package = pkgs.elasticsearch7;
    enable = true;
  };
}
