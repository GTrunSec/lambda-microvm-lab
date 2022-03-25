{
  self,
  inputs,
  channels,
  customModules,
  ...
}: {
  system = "x86_64-linux";
  channelName = "nixpkgs";
  imports = [(inputs.digga.lib.importExportableModules ./modules)];
  modules = [
    {_module.args.ourLib = self.lib;}
    inputs.home.nixosModules.home-manager
    inputs.microvm.nixosModules.microvm
    inputs.vault-secrets.nixosModules.vault-secrets
    inputs.airflow2nix.nixosModules.airflow

    customModules.nsm
    customModules.secrets
    {}
  ];
}
