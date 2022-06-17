{
  inputs,
  self,
  ...
}:
with inputs; {
  system = "x86_64-linux";
  channelName = "nixos";
  imports = [
    (digga.lib.importExportableModules ../modules/shared)
    (digga.lib.importExportableModules ../modules/nixos)
  ];
  modules = [
    {
      lib.our = self.lib;
      disabledModules = ["services/networking/nomad.nix"];
    }
    digga.nixosModules.bootstrapIso
    home.nixosModules.home-manager
    sops-nix.nixosModules.sops
    ragenix.nixosModules.age

    microvm.nixosModules.microvm
    microvm.nixosModules.host
    #User's custom modules

    vault-secrets.nixosModules.vault-secrets
    airflow2nix.nixosModules.airflow

    waterwheel.nixosModules.waterwheel
    zeek2nix.nixosModules.zeek
    vast2nix.nixosModules.vast
    vast2nix.nixosModules.vast-client

    threatbus2nix.nixosModules.threatbus
    threatbus2nix.nixosModules.threatbus-vast
  ];
}
