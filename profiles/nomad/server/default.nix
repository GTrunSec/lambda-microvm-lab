{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.firewall.allowedUDPPorts = [4647 4646];
  networking.firewall.allowedTCPPorts = [4647 4646];

  services.nomad = {
    enable = true;
    enableDocker = true;
    dropPrivileges = false;
    extraPackages = [pkgs.cni-plugins pkgs.consul];
    extraPlugins = [pkgs.nomad-driver-nix pkgs.nomad-driver-podman];
    settings = {
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
      client = {
        enabled = true;
        cni_path = "${pkgs.cni-plugins}/bin/";
      };
      vault = {
        enabled = true;
        address = "http://0.0.0.0:8200";
        token = "root";
      };

      plugin = {
        nix_driver.config.enabled = true;
        podman.config.enabled = true;
      };

      # FIXME: more generic way
      consul.address = config.machine.services.nomad.consul.address;
    };
  };
}
