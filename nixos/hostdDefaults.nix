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
    inputs.microvm.nixosModules.host
    inputs.microvm.nixosModules.microvm
    customModules.nsmModules
    customModules.sopsTemplate
    { }
  ];
}
