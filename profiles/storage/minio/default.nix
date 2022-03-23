{
  config,
  lib,
  pkgs,
  ...
}: {
  services.minio = {
    enable = true;
  };
}
