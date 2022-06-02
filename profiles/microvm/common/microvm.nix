{
  config,
  lib,
  pkgs,
  ...
}: {
  microvm.forwardPorts = [
    {
      from = "host";
      host.port = 5999;
      guest.port = 22;
    }
    # {
    #   from = "guest";
    #   host.port = 80;
    #   guest.port = 9999;
    # }
  ];
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
