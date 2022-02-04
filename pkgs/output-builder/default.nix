channels: inputs: self: {
  apps.vm = {
    type = "app";
    program =
      let
        inherit (self.nixosConfigurations.qemu) config;
      in
        "${config.system.build.vm}/bin/run-${config.networking.hostName}-vm";
  };
  packages.qemu-microvm-bridge = import ../../runners/bridge.nix { inherit channels inputs;};
}
