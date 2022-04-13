{
  config,
  lib,
  pkgs,
  ...
}: {
  services.nomad = {
    enable = true;
    enableDocker = true;
    dropPrivileges = false;
    extraPackages = [pkgs.cni-plugins pkgs.consul];
    settings = {
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
      client = {
        enabled = true;
        cni_path = "${pkgs.cni-plugins}/bin/";
      };
      # FIXME: more generic way
      consul.address = config.machine.services.nomad.consul.address;
    };
  };
}