{ config, lib, pkgs, ... }:

{
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
}
