{ self
, inputs
, ...
}:
with inputs;
with inputs.nixpkgs; rec {
  profiles =
    digga.lib.rakeLeaves ../profiles
    // {
      users = digga.lib.rakeLeaves ../users;
      tenzir = digga.lib.rakeLeaves ../profiles/tenzir;
      microvm = digga.lib.rakeLeaves ../profiles/microvm;
    };
  ##################
  # Profiles Tags  #
  ##################
  suites =
    with profiles; rec {
      base = [ core users.root users.admin ];
      ################
      # Tap Hosts    #
      ################
      tap_qemu_host = base ++ [ tenzir.vast ];
      tap_firecracker_1 = base ++ [ tenzir.vast-client microvm.tap ];
      tap_cloud-hypervisor_1 = base ++ [ tenzir.vast-client microvm.tap ];
      tap_cloud-hypervisor_2 = base ++ [ tenzir.vast-client microvm.tap ];
      ################
      # Bridge Hosts #
      ################
      bridge_qemu_1 = base ++ [ tenzir.vast ];
      firecracker_bridge_1 =
        base
        ++ [
          tenzir.vast
          # tenzir.client
        ];
      ###########################
      # single Hypervisor Hosts #
      ###########################
    };
}
