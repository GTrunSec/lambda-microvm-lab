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
    };
  ##################
  # Profiles Tags  #
  ##################
  suites = with profiles; rec {
    base = [core users.root users.admin];
    ################
    # Tap Hosts    #
    ################
    tap_common = [ microvm.common ];
    tap_qemu_host = base ++ [tenzir.vast tap_common];
    tap_qemu_1 = base ++ [tenzir.vast-client microvm.tap tap_common];
    tap_qemu_2 = base ++ [tenzir.vast-client microvm.tap tap_common];
    tap_firecracker_1 = base ++ [tenzir.vast-client microvm.tap tap_common];
    tap_cloud-hypervisor_1 = base ++ [tenzir.vast-client microvm.tap tap_common];
    tap_cloud-hypervisor_2 = base ++ [tenzir.vast-client microvm.tap tap_common];
    ################
    # Bridge Hosts #
    ################
    bridge_qemu_1 = base ++ [tenzir.vast];
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
