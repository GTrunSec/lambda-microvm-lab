{
  self,
  inputs,
  channels,
  customModules,
}: {
  system = "x86_64-linux";
  channelName = "nixos";
  imports = [(inputs.digga.lib.importExportableModules ./modules)];
  modules = [
    {
      _module.args.ourLib = self.lib;
      disabledModules = ["services/networking/nomad.nix"];
    }
    inputs.home.nixosModules.home-manager

    inputs.microvm.nixosModules.microvm
    inputs.vault-secrets.nixosModules.vault-secrets
    inputs.airflow2nix.nixosModules.airflow

    inputs.waterwheel.nixosModules.waterwheel

    customModules.nsm
    customModules.secrets
    {}
  ];
}
