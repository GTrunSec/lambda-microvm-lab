{
  config,
  lib,
  pkgs,
  ...
}: {
  age.identityPaths = [
    "/root/.ssh/id_ed25519"
  ];
}
