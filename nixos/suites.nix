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
      # Suites Tags  #
      ################
      qemu-host = base ++ [ tenzir.vast ];
      firecracker =
        base
        ++ [
          tenzir.vast
          # tenzir.client
        ];
      qemu-bridge = base ++ [ tenzir.vast ];
      firecracker-tap = base ++ [ tenzir.vast ];
    };
}
