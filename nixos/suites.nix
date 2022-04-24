{
  self,
  inputs,
  ...
}:
with inputs;
with inputs.nixpkgs; rec {
  profiles =
    digga.lib.rakeLeaves ../profiles
    // {
      users = digga.lib.rakeLeaves ../users;
      tenzir = digga.lib.rakeLeaves ../profiles/tenzir;
      microvm = digga.lib.rakeLeaves ../profiles/microvm;
      ssh = digga.lib.rakeLeaves ../profiles/ssh;
      zeek = digga.lib.rakeLeaves ../profiles/zeek;
      secrets = digga.lib.rakeLeaves ../profiles/secrets;
      database = digga.lib.rakeLeaves ../profiles/database;
      broker = digga.lib.rakeLeaves ../profiles/broker;
      storage = digga.lib.rakeLeaves ../profiles/storage;
      nomad = digga.lib.rakeLeaves ../profiles/nomad;
      consul = digga.lib.rakeLeaves ../profiles/consul;
    };
  ##################
  # Profiles Tags  #
  ##################
  suites = with profiles; rec {
    base = [core users.root users.admin ssh.core];
    ################
    # Tap Hosts    #
    ################
    tap-common = [microvm.common];
    tap-client = [
      tenzir.vast-client
      ssh.client
      microvm.tap-client
    ];
    tap-qemu-host = base ++ [ssh.host tap-common tenzir.vast];
    tap-qemu-1 = base ++ [tap-client tap-common zeek.sensor];
    tap-qemu-2 = base ++ [tap-client tap-common zeek.sensor];
    tap-firecracker-1 = base ++ [tap-client tap-common];
    tap-cloud-hypervisor-1 = base ++ [tap-client tap-common];
    tap-cloud-hypervisor-2 = base ++ [tap-client tap-common];
    # users #
    user-qemu-host = base ++ [microvm.common];
    ################
    # Bridge Hosts #
    ################
    bridge-common = [microvm.bridge];
    bridge-qemu-tap =
      base
      ++ [
        bridge-common
        microvm.common
        ssh.host
        secrets.age
        # ssh.host secrets.age zeek.cluster
        # tenzir.vast
        waterwheel
        broker.rabbitmq
      ];
    bridge-qemu-2 = base ++ [tenzir.vast microvm.common openctiProfile];
    bridge-firecracker-1 =
      base
      ++ [
        tenzir.vast
        # tenzir.client
      ];
    ###########################
    # single Hypervisor Hosts #
    ###########################

    ###############
    # nomad hosts #
    ###############
    openctiProfile = [
      database.redis
      elk.elasticsearch
      storage.minio
      broker.rabbitmq
    ];
    nomad-qemu-cluster = base ++ [microvm.common] ++ [nomad.server consul.server vault];
    nomad-tenzir-vast = base ++ [nomad.common tenzir.vast];
    nomad-tenzir-opencti = base ++ [nomad.common tenzir.vast openctiProfile];
    nomad-airflow = base ++ [nomad.common airflow];
    nomad-waterwheel = base ++ [nomad.common waterwheel];
    nomad-nixos = base ++ [nomad.common];
  };
}
