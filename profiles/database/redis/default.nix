{
  config,
  lib,
  pkgs,
  ...
}: {
  services.redis = {
    enable = true;
  };
}
