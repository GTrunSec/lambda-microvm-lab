{ self
, inputs
, ...
}:
with inputs;
with inputs.nixpkgs;
rec {
  profiles =
    digga.lib.rakeLeaves ../profiles
    // {
      users = digga.lib.rakeLeaves ../users;
      tenzir = digga.lib.rakeLeaves ../profiles/tenzir;
    };
  ##################
  # Profiles Tags  #
  ##################
  suites =
    with profiles;
    rec {
      base = [ users.root users.admin ];
      ################
      # Tap Hosts    #
      ################
      tap_qemu_host = base ++ [ tenzir.vast ];
      tap_firecracker_1 = base ++ [ tenzir.vast-client ];
      tap_cloud-hypervisor_1 = base ++ [ tenzir.vast-client ];
      tap_cloud-hypervisor_2 = base ++ [ tenzir.vast-client ];
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
