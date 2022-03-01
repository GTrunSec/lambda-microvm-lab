{ config
, lib
, pkgs
, ...
}:
{
  users.users.root.openssh.authorizedKeys.keys = [ ];
  services.zeek = {
    enable = true;
    node = ''
      [logger]
      type=logger
      host=${config.machine.services.zeek.cluster}

      [manager]
      type=manager
      host=${config.machine.services.zeek.cluster}

      [proxy-1]
      type=proxy
      host=${config.machine.services.zeek.cluster}

      [worker-1]
      type=worker
      host=${config.machine.services.zeek.cluster}
      interface=af_packet::${config.machine.services.zeek.interface}
      lb_method=custom
      lb_procs=2
      pin_cpus=0,1,2

      [worker-2]
      type=worker
      host=${config.machine.services.zeek.sensor.worker_2.host}
      interface=af_packet::${
      config.machine.services.zeek.sensor.worker_2.interface
    }
      lb_method=custom
      lb_procs=2
      pin_cpus=0,1,2
    '';
    package = pkgs.zeek-release.override { };
    # privateScript = ''
    #  '';
  };
}
