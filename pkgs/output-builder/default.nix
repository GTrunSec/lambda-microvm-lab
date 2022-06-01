channels: inputs: self: let
  mkApp = builtins.listToAttrs (
    map (
      name: {
        value = {
          type = "app";
          program = let
            inherit (self.nixosConfigurations."${name}") config;
            inherit (config.microvm) hypervisor;
          in "${config.microvm.runner."${hypervisor}"}/bin/microvm-run";
        };
        name = "${name}";
      }
    ) (builtins.attrNames self.nixosConfigurations)
  );
in {
  apps = {} // mkApp;
}
