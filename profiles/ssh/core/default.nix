{
  config,
  lib,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "yes";
  };
}
