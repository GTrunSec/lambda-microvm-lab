{ inputs
, pkgs
, ...
}:
{
  modules = with inputs; [ bud.devshellModules.bud ];
  exportedModules = [ ./commands.toml ];
}
