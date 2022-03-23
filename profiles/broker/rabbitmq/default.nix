{
  config,
  lib,
  pkgs,
  ...
}: {
  services.rabbitmq = {
    enable = true;
  };
}
