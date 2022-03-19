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
    tap-qemu-2 = base ++ [tap-client tap-common];
    tap-firecracker_1 = base ++ [tap-client tap-common];
    tap-cloud-hypervisor_1 = base ++ [tap-client tap-common];
    tap-cloud-hypervisor_2 = base ++ [tap-client tap-common];
    ################
    # Bridge Hosts #
    ################
    bridge-common = [microvm.bridge];
    bridge-qemu-tap = base ++ [tenzir.vast microvm.common bridge-common ssh.host secrets.age zeek.cluster];
    bridge-qemu-2 = base ++ [tenzir.vast microvm.common];
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
    nomad-nixos-1 = base ++ [tenzir.vast];
  };
}
