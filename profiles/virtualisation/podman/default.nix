{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.podman.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;
  users.extraUsers.root.extraGroups = ["podman"];
}
