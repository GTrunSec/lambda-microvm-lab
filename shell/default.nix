{ self, inputs, pkgs, ... }:
{
  modules = with inputs; [
    bud.devshellModules.bud
  ];
  exportedModules = [
    (inputs.devshell.lib.importTOML ./commands.toml)
  ];
}
