{ self
, inputs
, channels
, customModules
, ...
}:
{
  system = "x86_64-linux";
  channelName = "nixpkgs";
  imports = [ (inputs.digga.lib.importExportableModules ./modules) ];
  modules = [
    { _module.args.ourLib = self.lib; }
    inputs.home.nixosModules.home-manager
    inputs.microvm.nixosModules.host
    customModules.nsmModules
    customModules.sopsTemplate
    { }
  ];
}
