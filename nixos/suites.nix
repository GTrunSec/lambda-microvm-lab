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
    tap_common = [microvm.common];
    tap_client = [
      tenzir.vast-client
      ssh.client
      microvm.tap-client
    ];
    tap_qemu_host = base ++ [ssh.host tap_common tenzir.vast];
    tap_qemu_1 = base ++ [tap_client tap_common zeek.sensor];
    tap_qemu_2 = base ++ [tap_client tap_common];
    tap_firecracker_1 = base ++ [tap_client tap_common];
    tap_cloud-hypervisor_1 = base ++ [tap_client tap_common];
    tap_cloud-hypervisor_2 = base ++ [tap_client tap_common];
    ################
    # Bridge Hosts #
    ################
    bridge_common = [microvm.bridge];
    bridge_qemu_tap = base ++ [tenzir.vast microvm.common bridge_common ssh.host secrets.age zeek.cluster];
    bridge_qemu_2 = base ++ [tenzir.vast microvm.common];
    bridge_firecracker_1 =
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
    nomad_nixos_1 = base ++ [tenzir.vast];
  };
}
