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
      qemu-host = base ++ [ tenzir.vast ];
      firecracker-tap = base ++ [ tenzir.vast-client ];
      cloud-hypervisor-tap = base ++ [ tenzir.vast-client ];
      ################
      # Bridge Hosts #
      ################
      qemu-bridge = base ++ [ tenzir.vast ];
      ###########################
      # single Hypervisor Hosts #
      ###########################
      firecracker =
        base
        ++ [
          tenzir.vast
          # tenzir.client
        ];
    };
}
