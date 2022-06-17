{
  config,
  lib,
  pkgs,
  ...
}: {
  microvm.shares = [
    {
      # use "virtiofs" for MicroVMs that are started by systemd
      proto = "9p";
      tag = "ro-store";
      source = "/nix/store";
      mountPoint = "/nix/.ro-store";
    }
  ];
  # make home-manager writable
  # microvm.writableStoreOverlay = "/nix/var/nix/temproots";
}
