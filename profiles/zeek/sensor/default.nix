{ config
, lib
, pkgs
, ...
}:
{
  # zeekctl ssh permission
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN57V+fxFwpYz+2dulD13YH4V5MwYRy4AWckO4wBgpZ2 rootIdentityFile"
  ];
  services.zeek = {
    enable = true;
    sensor = true;
  };
}
