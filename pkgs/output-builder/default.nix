channels: inputs: self: {
  apps.vm = {
    type = "app";
    program =
      let
        inherit (self.nixosConfigurations.qemu) config;
        inherit (config.microvm) hypervisor;
      in
        "${config.microvm.runner.${hypervisor}}/bin/microvm-run";
  };
  packages.microvm-kernel = inputs.microvm.packages."x86_64-linux".microvm-kernel;
}
