{
  self,
  inputs,
  customModules,
  ...
}:
{
  nomad_nixos_1 = {
    modules = [
      customModules.nomad
    ];
  };
}
