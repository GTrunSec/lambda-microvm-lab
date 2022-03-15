{
  config,
  lib,
  pkgs,
  ...
}: {
  services.zeek = {
    enable = true;
    standalone = true;
    inherit (config.machine.services.zeek) host;
    inherit (config.machine.services.zeek) interface;
    package = pkgs.zeek-release.override {};
    # privateScript = ''
    # '';
  };
}
