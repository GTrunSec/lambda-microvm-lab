{
  config,
  lib,
  pkgs,
  ...
}: {
  services.consul = {
    enable = true;
    webUi = true;
    interface.bind = config.machine.services.consul.interface.bind;
    interface.advertise = config.machine.services.consul.interface.advertise;
    extraConfig = {
      server = true;
      bootstrap_expect = 1;
      autopilot.min_quorum = 1;
      connect.enabled = true;
      retry_join = [] ++ config.machine.services.consul.retry_join;
      client_addr = config.machine.services.consul.client_addr;
      ports.grpc = config.machine.services.consul.ports.grpc;
    };
  };
}
